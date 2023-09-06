Return-Path: <netdev+bounces-32319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274CE794194
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 18:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A316281469
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C4107B7;
	Wed,  6 Sep 2023 16:39:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD31079A
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 16:39:22 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE74F10F9
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 09:39:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so7910535ad.2
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694018360; x=1694623160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PD8rvz2Pu9RKRgVPiGKcLS2/XE15AismgCd3JB4z9+U=;
        b=lB14sG3ISn6seSAnrW/rJJ9E5hcBh4cQHl4f00ALnyzxOmt5EcAZjYnDbWpLfrSri9
         YWyR2R6I/ygnvOBL++tao9GZkrZGL3BlfYG4cyrbSXDnvXyvIHzgMDh7fYoznX5ng6Il
         JpvOaZY44leF86yRBPNdnWZ+6zs6aKZNhlahJIIf1SnGttdo1c1kgVfscH6ZUQxkL9Ht
         5TFt9ZFVvA5lB8umtljgflAGt7Esk75Ups/oENRLR+M8X53Q36hjciLtg5ZlpeqLXDak
         TivCtU2GBsNEYEf+x1lAWjUgagr9vZNUG3FWU/WzVYRdcfh2K/mAVxznIAsC6M08AJcp
         n0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694018360; x=1694623160;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD8rvz2Pu9RKRgVPiGKcLS2/XE15AismgCd3JB4z9+U=;
        b=UX14/NBUGf0bVgx89zhmQ/rjrS4XBtSJf+DRy7+hj3xT4py8bxOt8wGMkHx5CdirUC
         MN9XA9dPdtELbqXSqkmBPDTWZhjvAyC11fJy8kXUQ9QXX+Dx9bGdobNCH8DytPQhKgV+
         HQuCNWUHBJt1YiV3SLFpN6T/T87MXKqMNkimWZjEHtyo7cxsZ1Cftm2ULIRhlqifcAYG
         c4svTx0NssMU9xx0qmynJMhTa9hcwf3zGXTfM+qcXj993UTH0Aso4AF93VL/TRH3r15g
         HGWQhC9PvjO2GtZYHogdArrWl0n6zkShoB04KMx0L2P4tHRokzpyHh9KJRyc4Zdgl5pl
         o6kQ==
X-Gm-Message-State: AOJu0YyHEkNC89PsYOy1wvDEtk8hAW9HzkzCwHvFUXTelmWVovlSktNI
	KnrP+9b9iqcRjQizqViZHcWVOKgrT/Xlomr7iYw=
X-Google-Smtp-Source: AGHT+IGH7N21OE+BP/Pu19bmHfSbAYDZYrLJaYbut14KktqnaAjDFL2rRArjVWX3E9NQtuREkwoAPg==
X-Received: by 2002:a17:903:2642:b0:1bc:4f04:17f9 with SMTP id je2-20020a170903264200b001bc4f0417f9mr12506129plb.9.1694018359876;
        Wed, 06 Sep 2023 09:39:19 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id jb17-20020a170903259100b001bb28b9a40dsm11292527plb.11.2023.09.06.09.39.19
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:39:19 -0700 (PDT)
Date: Wed, 6 Sep 2023 09:39:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNNOUNCE] iproute2 6.5 release
Message-ID: <20230906093918.394a1b1d@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is the release of iproute2 corresponding to the 6.5 kernel.
Nothing major here, dcb received most of the changes.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.5.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Andrea Claudi (2):
      mptcp: add support for implicit flag
      treewide: fix indentation

Chander Govindarajan (2):
      misc/ifstat: fix incorrect output data in json mode
      misc/ifstat: fix incorrect output data in json mode

Daniel Machon (12):
      dcb: app: add new dcbnl attribute field
      dcb: app: replace occurrences of %d with %u for printing unsigned int
      dcb: app: move colon printing out of callbacks
      dcb: app: rename dcb_app_print_key_*() functions
      dcb: app: modify dcb_app_print_filtered() for dcb-rewr reuse
      dcb: app: modify dcb_app_table_remove_replaced() for dcb-rewr reuse
      dcb: app: expose functions required by dcb-rewr
      dcb: rewr: add new dcb-rewr subcommand
      dcb: rewr: add symbol for max DSCP value
      man: dcb-rewr: add new manpage for dcb-rewr
      man: dcb: add additional references under 'SEE ALSO'
      man: dcb-app: clean up a few mistakes

David Ahern (2):
      Update kernel headers
      Update kernel headers

Edwin Peer (1):
      iplink: filter stats using RTEXT_FILTER_SKIP_STATS

Gioele Barabucci (1):
      Read configuration files from /etc and /usr

Hangbin Liu (1):
      iplink_bridge: fix incorrect root id dump

Ido Schimmel (2):
      f_flower: Add l2_miss support
      f_flower: Treat port 0 as valid

Jakub Kicinski (2):
      ip: error out if iplink does not consume all options
      ss: report when the RxNoPad optimization is set on TLS sockets

Jiri Pirko (1):
      devlink: spell out STATE in devlink port function help

Kamal Heib (1):
      rdma: Report device protocol

Masatake YAMATO (2):
      tc: fix a wrong file name in comment
      man: (ss) fix wrong margin

Matthieu Baerts (3):
      ss: mptcp: display info counters as unsigned
      ss: mptcp: display seq related counters as decimal
      ss: mptcp: print missing info counters

Maximilian Bosch (1):
      ip-vrf: recommend using CAP_BPF rather than CAP_SYS_ADMIN

Nicolas Escande (2):
      bridge: link: allow filtering on bridge name
      man: bridge: update bridge link show

Paolo Lungaroni (1):
      seg6: man: ip-link.8: add description of NEXT-C-SID flavor for SRv6 End.X behavior

Phil Sutter (1):
      ss: Fix socket type check in packet_show_line()

Stephen Hemminger (10):
      dcb: fully initialize flag table
      fix fallthrough warnings
      ss: fix warning about empty if()
      ct: check for invalid proto
      ifstat: fix warning about conditional
      uapi: update headers to 6.5-rc1
      include: dual license the bpf helper includes
      Add missing SPDX headers
      uapi: update headers
      v6.5.0

Trevor Gamblin (1):
      bridge/mdb.c: include limits.h

Vladimir Nikishkin (1):
      ip-link: add support for nolocalbypass in vxlan

Vladimir Oltean (4):
      tc/taprio: print the offload xstats
      tc/taprio: fix parsing of "fp" option when it doesn't appear last
      tc/taprio: don't print netlink attributes which weren't reported by the kernel
      tc/taprio: fix JSON output when TCA_TAPRIO_ATTR_ADMIN_SCHED is present

Zahari Doychev (2):
      f_flower: add cfm support
      f_flower: simplify cfm dump function


