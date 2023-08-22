Return-Path: <netdev+bounces-29802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038B784C38
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 23:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DF92810A0
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A766B34CDF;
	Tue, 22 Aug 2023 21:49:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED62018C
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 21:49:49 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D80CD1
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:49:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso6055350a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692740984; x=1693345784;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A3lYfSvdwLHSiJBa15fACAe2lcso1A9kvgROvpkuwHM=;
        b=spae9cbB8oDHh/MV1iLuYLVbGQ92O9OFjk3BtfzZ/eMVOfozczIiwU6lAwgyeR2Gpe
         jsR/IbWHf1jDhO6DurhDdOU6TIoxP0BUSvO9aLKFJsr4+tsnCuRXsKAdPkEXzYCbYEQc
         BhJ3Uf9izlGKB7n7qbmo4w2+rtcJoQFgO7ps6Nm57UVTdFNe4EI6GLPCwZ5APSLXQdBp
         jFpPRvzP78p8eQJPfYdZxZkek/7ARoKKMl8hDWweRbSV9ivF+p67jdbf1fLZKlfqC/Ws
         tRbB5Xjzbx6YNQFKZe5TO7BkbUg6UvcT4a4C4SGOS61q5bTfkDP9ghOhWIvoi8vSAok3
         mWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692740985; x=1693345785;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3lYfSvdwLHSiJBa15fACAe2lcso1A9kvgROvpkuwHM=;
        b=CkQmi6rIAFj0JAoyYrBHCMdSdgw5RzZl90IlaSpHJSpJXNfhpKrWelcckgPNy8iFK7
         1CmwIWpyR0SzH7NdqfoA+h7uJIP/4LrcFyirKZmjj9bEMDspJutM75/XvSQQuVxo0c6b
         nVfj0EdFMDBoNWVisPbKXzgRuD6BtUr5Wsp+3w8dycIWEooZs9uZXu68zm52YfNvnnBs
         JMBEeA1ATm9+I6nUT+nX1ssb6Z4shga2I/2OJTHrA2+ydaGo2OAVLPFVIeXafi/ZDVmz
         on+m5rY7r2ZIDAnbCMH+22uKdJG1tA6ic6dzMJtnPNdtLC2EQIViFLwncOjLb0zzFAmn
         OjCw==
X-Gm-Message-State: AOJu0Yw20/KxRrPiihKWwJhF6RyMQOWItvx8UsJNKZ9zwTHMBDRExHNw
	UXsGLso7HkIcApzvgcqLUOfNYChPLkFPOQQSXVHjIwKvhxk=
X-Google-Smtp-Source: AGHT+IFv5w+uc9u4knGEyXJqAKI/N1sbB3pE72gvNE+xCXHleUmtfQQfJUzfvCUrw7+uv5Qdak6OpHDbLPvN+FahHvg=
X-Received: by 2002:a05:6402:3447:b0:522:1f09:dde3 with SMTP id
 l7-20020a056402344700b005221f09dde3mr9129647edc.3.1692740984381; Tue, 22 Aug
 2023 14:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brian Hutchinson <b.hutchman@gmail.com>
Date: Tue, 22 Aug 2023 17:49:33 -0400
Message-ID: <CAFZh4h9wHtTGFag-JDtjqFEmqnMoW4cTOr_CF3GQwKLb5jigrQ@mail.gmail.com>
Subject: Microchip net DSA with ptp4l getting tx_timeout failed msg using
 6.3.12 kernel and KSZ9567 switch
To: netdev@vger.kernel.org
Cc: Christian Eggers <ceggers@arri.de>, Vladimir Oltean <OlteanV@gmail.com>, arun.ramadoss@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Getting this tx_timestamp_timeout error over and over when I try to run ptp4l:

ptp4l[1366.143]: selected best master clock 001747.fffe.70151b
ptp4l[1366.143]: updating UTC offset to 37
ptp4l[1366.143]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
ptp4l[1366.860]: port 1: delay timeout
ptp4l[1376.871]: timed out while polling for tx timestamp
ptp4l[1376.871]: increasing tx_timestamp_timeout may correct this
issue, but it is likely caused by a driver bug
ptp4l[1376.871]: port 1: send delay request failed

I was using 5.10.69 with Christians patches before they were mainlined
and had everything working with the help of Christian, Vladimir and
others.

Now I need to update kernel so tried 6.3.12 which contains Christians
upstream patches and I also back ported v8 of the upstreamed patches
to 6.1.38 and I'm getting the same results with that kernel too.

I'm using ptp4l 2.0.1 in a yocto Dunfell release (3.1.24) on imx8mm platform.

I tried both lan1 and the failover bond1 I created between lan1 and
lan2 ports and had the same result.

I tried increasing tx_timestamp and it doesn't appear to matter.  I
feel like I had this problem before when first starting to work with
5.10.69 but can't remember if another patch resolved it.  With 5.10.69
I've got quite a few more patches than just the 13 that were mainlined
in 6.3.  Looking through old emails I want to say it might have been
resolved with net-dsa-ksz9477-avoid-PTP-races-with-the-data-path-l.patch
that Vladimir gave me but looking at the code it doesn't appear
mainline has that one.

As best as possible, I've checked kernel .config between this version
of kernel and what I was using before with 5.10.69 and I can't find a
smoking gun to figure out why this is happening.

Here's the output I get:

root@localhost: ptp4l -f my_ptp4l..conf -s -i bond1 -m -q -l 7
ptp4l[687.807]: config item (null).assume_two_step is 0
ptp4l[687.807]: config item (null).check_fup_sync is 0
ptp4l[687.807]: config item (null).tx_timestamp_timeout is 3000
ptp4l[687.807]: config item (null).clock_servo is 0
ptp4l[687.807]: config item (null).clock_type is 32768
ptp4l[687.807]: config item (null).clock_servo is 0
ptp4l[687.807]: config item (null).clockClass is 248
ptp4l[687.807]: config item (null).clockAccuracy is 254
ptp4l[687.807]: config item (null).offsetScaledLogVariance is 65535
ptp4l[687.807]: config item (null).productDescription is ';;'
ptp4l[687.807]: config item (null).revisionData is ';;'
ptp4l[687.807]: config item (null).userDescription is ';'
ptp4l[687.807]: config item (null).manufacturerIdentity is '00:00:00'
ptp4l[687.807]: config item (null).domainNumber is 44
ptp4l[687.807]: config item (null).slaveOnly is 1
ptp4l[687.808]: config item (null).gmCapable is 1
ptp4l[687.808]: config item (null).gmCapable is 1
ptp4l[687.808]: config item (null).G.8275.defaultDS.localPriority is 128
ptp4l[687.808]: config item (null).time_stamping is 4
ptp4l[687.808]: config item (null).twoStepFlag is 0
ptp4l[687.808]: config item (null).twoStepFlag is 0
ptp4l[687.808]: config item (null).time_stamping is 4
ptp4l[687.808]: config item (null).priority1 is 128
ptp4l[687.808]: config item (null).priority2 is 128
ptp4l[687.808]: interface index 6 is up
ptp4l[687.808]: config item (null).free_running is 0
ptp4l[687.808]: selected /dev/ptp1 as PTP clock
ptp4l[687.808]: config item (null).uds_address is '/var/run/ptp4l'
ptp4l[687.808]: section item /var/run/ptp4l.announceReceiptTimeout now 0
ptp4l[687.808]: section item /var/run/ptp4l.delay_mechanism now 0
ptp4l[687.808]: section item /var/run/ptp4l.network_transport now 0
ptp4l[687.808]: section item /var/run/ptp4l.delay_filter_length now 1
ptp4l[687.808]: config item (null).free_running is 0
ptp4l[687.808]: config item (null).freq_est_interval is 1
ptp4l[687.808]: config item (null).gmCapable is 1
ptp4l[687.808]: config item (null).kernel_leap is 1
ptp4l[687.808]: config item (null).utc_offset is 37
ptp4l[687.808]: config item (null).timeSource is 160
ptp4l[687.809]: config item (null).pi_proportional_const is 0.200000
ptp4l[687.809]: config item (null).pi_integral_const is 0.037500
ptp4l[687.809]: config item (null).pi_proportional_scale is 0.000000
ptp4l[687.809]: config item (null).pi_proportional_exponent is -0.300000
ptp4l[687.809]: config item (null).pi_proportional_norm_max is 0.700000
ptp4l[687.809]: config item (null).pi_integral_scale is 0.000000
ptp4l[687.809]: config item (null).pi_integral_exponent is 0.400000
ptp4l[687.809]: config item (null).pi_integral_norm_max is 0.300000
ptp4l[687.809]: config item (null).step_threshold is 0.000000
ptp4l[687.809]: config item (null).first_step_threshold is 0.000020
ptp4l[687.809]: config item (null).max_frequency is 900000000
ptp4l[687.809]: config item (null).dataset_comparison is 1
ptp4l[687.809]: config item (null).tsproc_mode is 0
ptp4l[687.809]: config item (null).delay_filter is 1
ptp4l[687.809]: config item (null).delay_filter_length is 5
ptp4l[687.809]: config item (null).initial_delay is 0
ptp4l[687.809]: config item (null).summary_interval is 4
ptp4l[687.809]: config item (null).sanity_freq_limit is 200000000
ptp4l[687.809]: PI servo: sync interval 1.000 kp 0.200 ki 0.037500
ptp4l[687.809]: config item /var/run/ptp4l.boundary_clock_jbod is 0
ptp4l[687.809]: config item /var/run/ptp4l.network_transport is 0
ptp4l[687.809]: config item /var/run/ptp4l.delayAsymmetry is 0
ptp4l[687.809]: config item /var/run/ptp4l.follow_up_info is 0
ptp4l[687.809]: config item /var/run/ptp4l.freq_est_interval is 1
ptp4l[687.809]: config item /var/run/ptp4l.net_sync_monitor is 0
ptp4l[687.809]: config item /var/run/ptp4l.path_trace_enabled is 0
ptp4l[687.809]: config item /var/run/ptp4l.tc_spanning_tree is 0
ptp4l[687.809]: config item /var/run/ptp4l.ingressLatency is 0
ptp4l[687.809]: config item /var/run/ptp4l.egressLatency is 0
ptp4l[687.809]: config item /var/run/ptp4l.delay_mechanism is 0
ptp4l[688.184]: config item /var/run/ptp4l.hybrid_e2e is 1
ptp4l[688.184]: port 0: hybrid_e2e only works with E2E
ptp4l[688.184]: config item /var/run/ptp4l.fault_badpeernet_interval is 16
ptp4l[688.184]: config item /var/run/ptp4l.fault_reset_interval is -128
ptp4l[688.185]: config item /var/run/ptp4l.tsproc_mode is 0
ptp4l[688.185]: config item /var/run/ptp4l.delay_filter is 1
ptp4l[688.185]: config item /var/run/ptp4l.delay_filter_length is 1
ptp4l[688.185]: config item bond1.boundary_clock_jbod is 0
ptp4l[688.185]: config item bond1.network_transport is 1
ptp4l[688.185]: config item bond1.delayAsymmetry is 0
ptp4l[688.185]: config item bond1.follow_up_info is 0
ptp4l[688.185]: config item bond1.freq_est_interval is 1
ptp4l[688.185]: config item bond1.net_sync_monitor is 0
ptp4l[688.185]: config item bond1.path_trace_enabled is 0
ptp4l[688.185]: config item bond1.tc_spanning_tree is 0
ptp4l[688.185]: config item bond1.ingressLatency is 0
ptp4l[688.185]: config item bond1.egressLatency is 0
ptp4l[688.185]: config item bond1.delay_mechanism is 1
ptp4l[688.185]: config item bond1.unicast_master_table is 1
ptp4l[688.185]: config item bond1.unicast_req_duration is 300
ptp4l[688.185]: section item bond1.hybrid_e2e now 1
ptp4l[688.185]: config item bond1.unicast_listen is 1
ptp4l[688.185]: section item bond1.hybrid_e2e now 1
ptp4l[688.185]: config item bond1.inhibit_multicast_service is 1
ptp4l[688.185]: config item bond1.hybrid_e2e is 1
ptp4l[688.185]: config item bond1.fault_badpeernet_interval is 16
ptp4l[688.185]: config item bond1.fault_reset_interval is -128
ptp4l[688.185]: config item bond1.tsproc_mode is 0
ptp4l[688.185]: config item bond1.delay_filter is 1
ptp4l[688.185]: config item bond1.delay_filter_length is 5
ptp4l[688.185]: config item bond1.logMinDelayReqInterval is 0
ptp4l[688.185]: config item bond1.logAnnounceInterval is 1
ptp4l[688.185]: config item bond1.announceReceiptTimeout is 3
ptp4l[688.185]: config item bond1.syncReceiptTimeout is 0
ptp4l[688.185]: config item bond1.transportSpecific is 0
ptp4l[688.185]: config item bond1.ignore_transport_specific is 0
ptp4l[688.185]: config item bond1.masterOnly is 0
ptp4l[688.185]: config item bond1.G.8275.portDS.localPriority is 128
ptp4l[688.185]: config item bond1.logSyncInterval is 0
ptp4l[688.185]: config item bond1.logMinPdelayReqInterval is 0
ptp4l[688.185]: config item bond1.neighborPropDelayThresh is 20000000
ptp4l[688.185]: config item bond1.min_neighbor_prop_delay is -20000000
ptp4l[688.185]: config item bond1.udp_ttl is 1
ptp4l[688.186]: config item (null).dscp_event is 0
ptp4l[688.186]: config item (null).dscp_general is 0
ptp4l[688.186]: port 1: INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[688.186]: config item /var/run/ptp4l.logMinDelayReqInterval is 0
ptp4l[688.186]: config item /var/run/ptp4l.logAnnounceInterval is 1
ptp4l[688.186]: config item /var/run/ptp4l.announceReceiptTimeout is 0
ptp4l[688.186]: config item /var/run/ptp4l.syncReceiptTimeout is 0
ptp4l[688.186]: config item /var/run/ptp4l.transportSpecific is 0
ptp4l[688.186]: config item /var/run/ptp4l.ignore_transport_specific is 0
ptp4l[688.186]: config item /var/run/ptp4l.masterOnly is 0
ptp4l[688.186]: config item /var/run/ptp4l.G.8275.portDS.localPriority is 128
ptp4l[688.186]: config item /var/run/ptp4l.logSyncInterval is 0
ptp4l[688.186]: config item /var/run/ptp4l.logMinPdelayReqInterval is 0
ptp4l[688.186]: config item /var/run/ptp4l.neighborPropDelayThresh is 20000000
ptp4l[688.186]: config item /var/run/ptp4l.min_neighbor_prop_delay is -20000000
ptp4l[688.186]: config item (null).uds_address is '/var/run/ptp4l'
ptp4l[688.186]: port 0: INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[688.186]: port 1: received link status notification
ptp4l[688.186]: interface index 6 is up
ptp4l[688.247]: port 1: setting asCapable
ptp4l[688.259]: port 1: new foreign master 001747.fffe.70151b-1
ptp4l[692.186]: port 1: unicast request timeout
ptp4l[692.188]: port 1: unicast ANNOUNCE granted for 300 sec
ptp4l[692.188]: port 1: renewal timeout at 917
ptp4l[692.296]: selected best master clock 001747.fffe.70151b
ptp4l[692.296]: updating UTC offset to 37
ptp4l[692.296]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
ptp4l[693.710]: port 1: delay timeout
ptp4l[696.714]: timed out while polling for tx timestamp
ptp4l[696.714]: increasing tx_timestamp_timeout may correct this
issue, but it is likely caused by a driver bug
ptp4l[696.714]: port 1: send delay request failed
ptp4l[696.714]: port 1: clearing fault immediately
ptp4l[696.715]: config item bond1.logMinDelayReqInterval is 0
ptp4l[696.715]: config item bond1.logAnnounceInterval is 1
ptp4l[696.715]: config item bond1.announceReceiptTimeout is 3
ptp4l[696.715]: config item bond1.syncReceiptTimeout is 0
ptp4l[696.715]: config item bond1.transportSpecific is 0
ptp4l[696.715]: config item bond1.ignore_transport_specific is 0
ptp4l[696.715]: config item bond1.masterOnly is 0
ptp4l[696.715]: config item bond1.G.8275.portDS.localPriority is 128
ptp4l[696.715]: config item bond1.logSyncInterval is 0
ptp4l[696.715]: config item bond1.logMinPdelayReqInterval is 0
ptp4l[696.715]: config item bond1.neighborPropDelayThresh is 20000000
ptp4l[696.715]: config item bond1.min_neighbor_prop_delay is -20000000
ptp4l[696.715]: config item bond1.udp_ttl is 1
ptp4l[696.716]: config item (null).dscp_event is 0
ptp4l[696.716]: config item (null).dscp_general is 0
ptp4l[696.716]: port 1: UNCALIBRATED to LISTENING on INIT_COMPLETE
ptp4l[696.716]: port 1: received link status notification
ptp4l[696.716]: interface index 6 is up
ptp4l[697.330]: port 1: setting asCapable
ptp4l[698.351]: port 1: new foreign master 001747.fffe.70151b-1
ptp4l[700.716]: port 1: unicast request timeout
ptp4l[700.717]: port 1: unicast SYNC granted for 300 sec
ptp4l[700.717]: PI servo: sync interval 1.000 kp 0.200 ki 0.037500
ptp4l[700.717]: port 1: unicast DELAY_RESP granted for 300 sec
ptp4l[702.387]: selected best master clock 001747.fffe.70151b
ptp4l[702.387]: updating UTC offset to 37
ptp4l[702.387]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
ptp4l[703.614]: port 1: delay timeout
ptp4l[706.618]: timed out while polling for tx timestamp
ptp4l[706.618]: increasing tx_timestamp_timeout may correct this
issue, but it is likely caused by a driver bug
ptp4l[706.618]: port 1: send delay request failed
ptp4l[706.618]: port 1: clearing fault immediately
ptp4l[706.619]: config item bond1.logMinDelayReqInterval is 0
ptp4l[706.619]: config item bond1.logAnnounceInterval is 1
ptp4l[706.619]: config item bond1.announceReceiptTimeout is 3
ptp4l[706.619]: config item bond1.syncReceiptTimeout is 0
ptp4l[706.619]: config item bond1.transportSpecific is 0
ptp4l[706.619]: config item bond1.ignore_transport_specific is 0
ptp4l[706.619]: config item bond1.masterOnly is 0
ptp4l[706.619]: config item bond1.G.8275.portDS.localPriority is 128
ptp4l[706.619]: config item bond1.logSyncInterval is 0
ptp4l[706.619]: config item bond1.logMinPdelayReqInterval is 0
ptp4l[706.619]: config item bond1.neighborPropDelayThresh is 20000000
ptp4l[706.619]: config item bond1.min_neighbor_prop_delay is -20000000
ptp4l[706.619]: config item bond1.udp_ttl is 1
ptp4l[706.620]: config item (null).dscp_event is 0
ptp4l[706.620]: config item (null).dscp_general is 0
ptp4l[706.620]: port 1: UNCALIBRATED to LISTENING on INIT_COMPLETE
ptp4l[706.620]: port 1: received link status notification
ptp4l[706.620]: interface index 6 is up
ptp4l[707.406]: port 1: setting asCapable
ptp4l[708.425]: port 1: new foreign master 001747.fffe.70151b-1
ptp4l[710.621]: port 1: unicast request timeout
ptp4l[712.432]: selected best master clock 001747.fffe.70151b
ptp4l[712.432]: updating UTC offset to 37
ptp4l[712.433]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
ptp4l[714.001]: port 1: delay timeout
ptp4l[717.005]: timed out while polling for tx timestamp
ptp4l[717.005]: increasing tx_timestamp_timeout may correct this
issue, but it is likely caused by a driver bug
ptp4l[717.005]: port 1: send delay request failed
ptp4l[717.005]: port 1: clearing fault immediately
ptp4l[717.005]: config item bond1.logMinDelayReqInterval is 0
ptp4l[717.005]: config item bond1.logAnnounceInterval is 1
ptp4l[717.005]: config item bond1.announceReceiptTimeout is 3
ptp4l[717.005]: config item bond1.syncReceiptTimeout is 0
ptp4l[717.005]: config item bond1.transportSpecific is 0
ptp4l[717.005]: config item bond1.ignore_transport_specific is 0
ptp4l[717.005]: config item bond1.masterOnly is 0
ptp4l[717.005]: config item bond1.G.8275.portDS.localPriority is 128
ptp4l[717.005]: config item bond1.logSyncInterval is 0
ptp4l[717.006]: config item bond1.logMinPdelayReqInterval is 0
ptp4l[717.006]: config item bond1.neighborPropDelayThresh is 20000000
ptp4l[717.006]: config item bond1.min_neighbor_prop_delay is -20000000
ptp4l[717.006]: config item bond1.udp_ttl is 1
ptp4l[717.006]: config item (null).dscp_event is 0
ptp4l[717.006]: config item (null).dscp_general is 0
ptp4l[717.007]: port 1: UNCALIBRATED to LISTENING on INIT_COMPLETE
ptp4l[717.007]: port 1: received link status notification
ptp4l[717.007]: interface index 6 is up
ptp4l[717.442]: port 1: setting asCapable

Here is my ptp4l config:

[global]
#
# Default Data Set
#
twoStepFlag             0
slaveOnly               1
priority1               128
#priority2               255
priority2               128
domainNumber            44
#utc_offset             37
clockClass              248
#clockClass              255
#step_window            48
clockAccuracy           0xFE
offsetScaledLogVariance 0xFFFF
free_running            0
freq_est_interval       1
dscp_event              0
dscp_general            0
#dataset_comparison     ieee1588
#for G.8275.1
dataset_comparison      G.8275.x
G.8275.defaultDS.localPriority  128
#
# Port Data Set
#
logAnnounceInterval     1
logSyncInterval         0
logMinDelayReqInterval  0
logMinPdelayReqInterval 0
announceReceiptTimeout  3
syncReceiptTimeout      0
delayAsymmetry          0
fault_reset_interval    -128
#fault_reset_interval    4
neighborPropDelayThresh 20000000
masterOnly              0
G.8275.portDS.localPriority     128
#
# Run time options
#
assume_two_step         0
logging_level           6
path_trace_enabled      0
follow_up_info          0
hybrid_e2e              1
inhibit_multicast_service       1
net_sync_monitor        0
tc_spanning_tree        0
#tx_timestamp_timeout    300
#tx_timestamp_timeout   1000
tx_timestamp_timeout    10000
unicast_listen          1
unicast_req_duration    300
unicast_master_table    1
use_syslog              0
verbose                 0
summary_interval        4
kernel_leap             1
check_fup_sync          0
#
# Servo Options
#
#servo_offset_threshold 100
#servo_num_offset_values        64
pi_proportional_const   0.2
pi_integral_const       0.0375
pi_proportional_scale   0.0
pi_proportional_exponent        -0.3
pi_proportional_norm_max        0.7
pi_integral_scale       0.0
pi_integral_exponent    0.4
pi_integral_norm_max    0.3
step_threshold          0.0
#step_threshold         0.00002
first_step_threshold    0.00002
max_frequency           900000000
clock_servo             pi
sanity_freq_limit       200000000
ntpshm_segment          0
#
# Transport options
#
transportSpecific       0x0
ptp_dst_mac            01:1B:19:00:00:00
p2p_dst_mac            01:80:C2:00:00:0E
udp_ttl                 1
#udp6_scope             0x0E
uds_address             /var/run/ptp4l
#
# Default interface options
#
#clock_type              OC
network_transport       UDPv4
#delay_mechanism         P2P
delay_mechanism         E2E
time_stamping           p2p1step
#time_stamping           onestep
#time_stamping           hardware
tsproc_mode             filter
#tsproc_mode            raw
#tsproc_mode            raw_weight
delay_filter            moving_median
delay_filter_length     5
egressLatency           0
ingressLatency          0
boundary_clock_jbod     0
#
# Clock description
#
productDescription      ;;
revisionData            ;;
manufacturerIdentity    00:00:00
userDescription         ;
timeSource              0xA0
#maxStepsRemoved                255
#
[unicast_master_table]
table_id                        1
logQueryInterval                2
#UDPv4                           192.168.0.250
UDPv4                           192.168.1.250
#
[lan1]
unicast_master_table            1

cat /proc/interrupts:

          CPU0       CPU1       CPU2       CPU3
11:     323676        486        484        489     GICv3  30 Level
 arch_timer
14:      50097          0          0          2     GICv3  79 Level
 timer@306a0000
15:          0          0          0          0     GICv3  23 Level     arm-pmu
16:          0          0          0          0     GICv3 135 Level
 302c0000.dma-controller
17:          0          0          0          0     GICv3  66 Level
 302b0000.dma-controller
18:          0          0          0          0     GICv3  34 Level
 30bd0000.dma-controller
19:       3385          0          0          0     GICv3  59 Level
 30890000.serial
20:       1670          0          0          0     GICv3 139 Level
 30bb0000.spi
21:          0          0          0          0     GICv3  51 Level
 rtc alarm
22:          0          0          0          0     GICv3 110 Level
 30280000.watchdog
23:       7579          0          0          0     GICv3  56 Level     mmc2
25:          0          0          0          0     GICv3 127 Level     sai
26:          0          0          0          0     GICv3  82 Level     sai
32:          0          0          0          0  gpio-mxc   3 Level
 bd718xx-irq
39:         16          0          0          0  gpio-mxc  10 Level
 global_port_irq
44:          0          0          0          0  gpio-mxc  15 Edge
 30b50000.mmc cd
197:    1183025          0          0          0     GICv3  67 Level
  30a20000.i2c
198:          0          0          0          0  bd718xx-irq   5 Edge
     gpio_keys
199:          0          0          0          0     GICv3  68 Level
  30a30000.i2c
200:          0          0          0          0     GICv3  69 Level
  30a40000.i2c
201:          0          0          0          0     GICv3  70 Level
  30a50000.i2c
202:          0          0          0          0     GICv3  64 Level
  30830000.spi
203:          0          0          0          0     GICv3 150 Level
  30be0000.ethernet
204:          0          0          0          0     GICv3 151 Level
  30be0000.ethernet
205:       6819          0          0          0     GICv3 152 Level
  30be0000.ethernet
206:          0          0          0          0     GICv3 153 Level
  30be0000.ethernet
207:          0          0          0          0     GICv3  55 Level     mmc1
208:         16          0          0          0   ksz-irq   0 Edge
  port_irq-0
209:          0          0          0          0   ksz-irq   1 Edge
  port_irq-1
217:         16          0          0          0   ksz-irq   2 Edge
  ptp-irq-0
218:          0          0          0          0   ksz-irq   0 Edge
  pdresp-msg
219:         16          0          0          0   ksz-irq   1 Edge
  xdreq-msg
220:          0          0          0          0   ksz-irq   2 Edge
  sync-msg
223:          0          0          0          0   ksz-irq   2 Edge
  ptp-irq-1
224:          0          0          0          0   ksz-irq   0 Edge
  pdresp-msg
225:          0          0          0          0   ksz-irq   1 Edge
  xdreq-msg
226:          0          0          0          0   ksz-irq   2 Edge
  sync-msg
228:          0          0          0          0     GICv3  36 Level
  30370000.snvs:snvs-powerkey
229:          0          0          0          0     GICv3 130 Level
  imx8_ddr_perf_pmu
230:        213          0          0          0     GICv3 137 Level
  30901000.jr
231:          0          0          0          0     GICv3 138 Level
  30902000.jr
232:          0          0          0          0     GICv3 146 Level
  30903000.jr
IPI0:         6        371        371        370       Rescheduling interrupts
IPI1:        24         63         63         63       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for
crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast
interrupts
IPI5:     28207          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrupts

Please let me know if I need to supply more data or answer questions
to track this down.

Regards,

Brian

