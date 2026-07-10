Return-Path: <netdev+bounces-306614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MNOXIvMMUWqs+gIAu9opvQ
	(envelope-from <netdev+bounces-306614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:17:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 789B973C27C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:17:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gQjrjh+Z;
	dkim=pass header.d=redhat.com header.s=google header.b=L45zANQ4;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306614-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306614-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DB3A30285B0
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E8B23B62B;
	Fri, 10 Jul 2026 15:04:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4DE233932
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:04:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695861; cv=none; b=crGC1MtkdFiEut8GMMn/zSf2Ens/1MleUcM673ajrkGKdszNmnR/aoZ45xsGfbjWIZxc5M3O5+4l5J0EQk3AGL1t3Ky10fgeZvzQpNzKVqF/M7CRv1e9Lyqds6Gmc/LszKOrCIu7cEVHVmtRnKsP2u/IfOP2oiLMJ6fIYa/4VMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695861; c=relaxed/simple;
	bh=JeCdlD97bIA/QnyswfXLEsugKd/idecrJqTRcWkU6xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBF/Zx2llfVodprBerVo82sE+9H4k4O2u02VkV8LH2nJqsM3sRhAADhmMQeRxljHZwURNvxMdUTozjBDW3c27NEUQqCQLlOGPkrDDh1IS43C+laPoWC3dluGSun8vBxoMdjXG0gbzScgu/7VMlO9XOHuhsz0eErED7PlULODTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQjrjh+Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L45zANQ4; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783695859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/GmInzvVPFnMY/yhKENHqDXBk4NC1kp5OgYqVDC6DY=;
	b=gQjrjh+ZTU5Q2TsCVWQKeSMbKvEa3+Mc2g6f3Iu1nqE5HWzokS0oHYzSlepe+Bbw6pfBDs
	MXJR/V1eSQRsXkgBdKT6wD21V/MPAEIiOUld8b93T4EY91pR6bhCUuyd97lsRMWANdrAw9
	9TiBloyyMNFU0SrKGpGH6iEby8MVONM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-qxB9e-zDP4SdonXPgozSMQ-1; Fri, 10 Jul 2026 11:04:15 -0400
X-MC-Unique: qxB9e-zDP4SdonXPgozSMQ-1
X-Mimecast-MFC-AGG-ID: qxB9e-zDP4SdonXPgozSMQ_1783695854
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bf840a69so7134805e9.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783695854; x=1784300654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/GmInzvVPFnMY/yhKENHqDXBk4NC1kp5OgYqVDC6DY=;
        b=L45zANQ4vk2EXDN55zm8FWljBc+jwltvAxI5EIw35OFNdEDaSxAyczvvyXt88QP/ZO
         D1hSLzxAVTqFltGOaszTKVRxj4yeShjK5JshlhyIMIMGpQ0DU7pRJARLLtuDDVDP81+t
         DUkaag/6XM2gMXEj0KFmhHhPQSbH0li4QyMrS40F/7CGNsyH1moh8x7jqlJMOIVrdSBP
         jtG8Jj1e3NgKmQPQKR+ZVdFZT2cMPHlafbedsmWB5Ss+h2w0Qe9u52yVlGR/v5R1Zlk1
         xi2/lbr9s6fdi13Sl21TmCJr+ksHAksTDUXGNKxez6hBDNHBUQ5uRaUAt1ImU3IYU3Il
         htjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783695854; x=1784300654;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/GmInzvVPFnMY/yhKENHqDXBk4NC1kp5OgYqVDC6DY=;
        b=opHY8C7713RKvPNencouvMqYrv8Oe/tQXb1AhARFa/6UzvI/tic5A6CyK7zR+dxoO2
         aZ86MHEp38waPYM4IW1yfRnzUmaNuZz/xIm1PqFKN8sd8k5p93X7oe8TFzOZQE+91n1k
         4RxSXGNPN1H23dAQm4JCiI4PN9bWR1Lxiio1Qg6wEfF+nhhUSNtLz+lXQCzYPWpTeeCS
         5BBPMRxH0OcAbvHQejntRSpXKsGvzw5Br0XYd2HJ2gBXrdP1k6BrgvoSp/fKKNKDPlW4
         X5c6AlKGOfCOVOuYTqkKlpHZUIOAZgDS9L2dUuX4AG5/2vl+vQMtx0zced18UqszXjLm
         Wq6g==
X-Forwarded-Encrypted: i=1; AHgh+RoO318cfLLV8Z5UQbK2N2ieilOaltplYSMqvVbm2sYGmZbTNH4Um3Gu+0OiVNGnE/zuQZpPVbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxegYuzobNHeho0IKv6pJLnSx23y5x+1cFB9g7x8HckeX3fhgPn
	dQr4A2Yx4dC7im7nB9uGO6U22EWdcDzriVasPAFlUhmmlNDrQnZQyUvDULxKPvalBJqp36f8xhd
	mijmWPb1JhKMPvcnCdgjCUm1xI7ywnezt8Gxg3Etvv3Zlk3oUf5x53CfWfg==
X-Gm-Gg: AfdE7clZyoVxW55OZdx1sCx5QKQI2+VV7nax7UidkCeto6lbFeVWhRluvukhx4mn7MT
	TdhVj71vQBlos496aTJojVUqL1W48yL49qyAWiEz61detDlyVxQ9PnAihFs5O97eNXuyKVyuGPO
	yjk/L97gtWBxLODOjgCRLNnXGAeoWxNaHIn78STsrMgGmoQW+NIWPTsF+vVFTKqXhAdo8GELQRa
	/TJkMXnZ4dlTB6AsanRvcwZRSQ2D+H+0P6SLN/y5ZvHS/7i9eIFCJAPC7kgMUIli/SFaVoOLk9V
	sxsLkEB+GHG6VfqFAT8j1TBz4dsrDghElqGPD/tykmt9/KgUZ6qYELi2tysSF+094fk2N3PgP6q
	czau6n/PnhXxqkwn8M13c41MbrURixINFP+CnnafbVyn7cF9PFQcq3ib2Pv3Lyq9YOiAUHU1+Xl
	gwLbhJxbHd6I7t
X-Received: by 2002:a05:600c:4505:b0:493:bfea:2780 with SMTP id 5b1f17b1804b1-493e68b83aemr125845255e9.9.1783695854274;
        Fri, 10 Jul 2026 08:04:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4505:b0:493:bfea:2780 with SMTP id 5b1f17b1804b1-493e68b83aemr125844595e9.9.1783695853700;
        Fri, 10 Jul 2026 08:04:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e6607fsm50370575e9.1.2026.07.10.08.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:04:12 -0700 (PDT)
Message-ID: <64a67818-877f-4aa9-aa71-5d4a70512b47@redhat.com>
Date: Fri, 10 Jul 2026 17:04:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/7] idpf: support pacing offload
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 horms@kernel.org, andrew@lunn.ch, Willem de Bruijn <willemb@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Joshua A Hay <joshua.a.hay@intel.com>, netdev@vger.kernel.org
References: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
 <20260706133433.3142805-4-willemdebruijn.kernel@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260706133433.3142805-4-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,lunn.ch,gmail.com,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306614-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,m:willemdebruijn.kernel@gmail.com,m:joshua.a.hay@intel.com,m:netdev@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 789B973C27C

On 7/6/26 3:34 PM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> If skb->tstamp is in the future, program this future delivery txtime
> in the transmit descriptor.
> 
> TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
> the FQ offload_horizon is configured.
> 
> But device support for pacing offload must be more robust. It can also
> be reached through SO_TXTIME.
> 
> Bound check txtime. Only packets with timestamp between now and the
> horizon (max_pacing_offload_horizon) are offloaded.
> 
> Support only in splitq mode, where tx and tx completion queues are
> separate and so completions can be returned out of order.
> 
> Assume that the NIC clock is PTP synchronized to CLOCK_TAI. This
> can later be refined, e.g., to a custom CLOCK_AUX.
> 
> Disable if in netpoll. It does not need the feature, and the ktime
> functions are not safe to call in this context.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Joshua A Hay <joshua.a.hay@intel.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
I think this deserves an explicit ack from @intel

Could you please have a look?

/P




