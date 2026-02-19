Return-Path: <netdev+bounces-259574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IdiNlBhl2kAxgIAu9opvQ
	(envelope-from <netdev+bounces-259574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:15:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50C161E27
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8372730226B5
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E032FFF8E;
	Thu, 19 Feb 2026 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL+zcT/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9542F39C2
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771528519; cv=none; b=akvpPJCOyzO0eeALEY49evL8ypPdeJycRxbSRfiDLjbnH0Al+eZjUodan9VVG30Enxd19eVhKFra0bMfnJl/SzKU+bFow8nxu71QXjWOLUNFPCL0QLCUtfkhwz5wPRJguEcVi1LyV2J/XuhQqBtvdXX6/jiOqXYQOfA6FJe85Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771528519; c=relaxed/simple;
	bh=0gkmir7Dg84DIj2NqS7pC8gGD0qGSz0cFFvUXtQdQMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5CR4n6ytdcVPsTDgaGW8sS94hYRTO03zVrOoYNwBtHTxyfjAVyTY7uQzNLNvc932Q03OQRnvcvMLhKL2Wgm/2gv7CMeflnLUoyeZd2Hs/c2gw02yJByIDfoyDNqD/fK7/29xZyenvbfa5zXRevlVFoIWE/doq2WrEnTKM1SG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL+zcT/h; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2baab3137bcso1171694eec.0
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 11:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771528516; x=1772133316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKXPKRIMQX0M/LU7nK6tMFNe40zI+JHq9z0mH/36x9E=;
        b=WL+zcT/hlNDs7HDTTsYFfGTB8g/0kik6EvUdgHmLCaYcbUnr3QBYqUo3dGf4GDYE11
         m74cl//wYTy0mujBgrv8iN/t7eXz12N2ZM+Yvf/xnsZ+gaIgrQsK+M1EZpCeSQpTiAfG
         S8S8Qw9IaRPMM0zymw5y/VWxmuKF+LSYMl3jFVLMYPbZ+Ox9fVkLsTX+fAV4fdIJ/OuP
         HduJIk/6eDlr5XkmQYDlfwLNPF5P9BPHJhhcG93ndtOXi6+UXRnZVVS5u6Lm6TadiI4/
         21qBeQ4XR2pKjHnLiS2+4S6dcOCFg7oPCdcurZX6qJTMt9HQPKyrKnDlZozj7gPEwMSa
         VKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771528516; x=1772133316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKXPKRIMQX0M/LU7nK6tMFNe40zI+JHq9z0mH/36x9E=;
        b=HBT6c9NYs8bwRZZ/Dtv9whShJNHI6tBtJkjTs95F4jn90n6Q8SylESbByHqOLAzaNt
         zySvvl7vHvRB85ziBKUtZ5bA4ChD9j++1qL7oS2Zfxkc0Z3w9nOTCoS2Ep76nihTGwrc
         ZlaP2zRKEIjZICz8CsU/qk483oTGTdvee2wz9gTjeO35/8Lzwvkpoq0SR3TZbg30kYHo
         cMqdlNz8t0H3gXhjrcKD1CyV/0Q4FLiaSU7w7asrzYFQdsdP1CXbpAxbcwB85A2RnGdR
         z8lMKdzosPSd4CpaRTXpAtD4xBmi1/CoNoRN2A2YyFklvdC5/kQIpqDTH4Msq60e0lvx
         +Ysg==
X-Forwarded-Encrypted: i=1; AJvYcCWUL+H0Rtmac9IDtAhu9hkabtx3AC4jeb6ARFzC6hOVHniDN5aSNOX9P/AmYu2SrEm3Ems5WUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6c9EkzQxiF/+mqoGSWTHlDINty1b/BcpAfsxEyoh2y6TUo3fn
	YJKwzg1u4DC4OFH1kppX8zTgaZK1dDYZhp+glDJ5GUSL2zeyBGxQpuM=
X-Gm-Gg: AZuq6aIMrgZVlrfUhAC2sF1BmZYpwEcE0N0puOKyvWCMPDR+U2+QoYrjtIpNlPKXU+W
	mU84hvK9mHLFmObI4My+mni6jbqJAwNL5ieaLEDJaLV/ZvkK4nHSszA1hHI49cYWsa56EoOgpNV
	mn5Os/Sg/hkXd7aH/I1vG/J3yWcoTWQH0GT9NCS+LanMWt3/mN3TiE+ePTkoG+azsfBm/QAO1k8
	nKP8+66A8vHs7JB4LEAl0rXgg9wRpTF2WJb+/Anu2ietlMvzGW8cXOFWPISrDwZMY0v4gxseMNG
	ddUCQv3i1g2Wfx3tosMgVLdbpslOnPwjwlrdndJsPwPKUHyTvJqRio3XeklKskmi4cdGyy1ZjqO
	EF88igdlCuEN0nrzURC7KHah2g/837HH6S5iFIXgeFm+KNDBUN+LA0TehrZ3HtWB/dwv2pficxs
	FY4d2KUFTWp6tN4vDJ5fwWO6HLELjfIz1LkuI67CvI9AFkFKN6Ym0rLhzyhxExQk1HzcVr8MaaD
	2n2fHfbvzX+0UqoYQ==
X-Received: by 2002:a05:7301:d1a:b0:2ba:8f0d:cfe with SMTP id 5a478bee46e88-2bac933a6femr9943515eec.9.1771528515983;
        Thu, 19 Feb 2026 11:15:15 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658fc4sm25299392eec.22.2026.02.19.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:15:15 -0800 (PST)
Date: Thu, 19 Feb 2026 11:15:14 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com
Subject: Re: [PATCH bpf-next] xsk: avoid double checking against rx queue
 being full
Message-ID: <aZdhQv_VEc5VgsSU@mini-arch>
References: <20260218150000.301176-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260218150000.301176-1-maciej.fijalkowski@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259574-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 3B50C161E27
X-Rspamd-Action: no action

On 02/18, Maciej Fijalkowski wrote:
> Currently non-zc xsk rx path for multi-buffer case checks twice if xsk
> rx queue has enough space for producing descriptors:
> 1.
> 	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> 		xs->rx_queue_full++;
> 		return -ENOBUFS;
> 	}
> 2.
> 	__xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_CONTD : 0);
> 	-> err = xskq_prod_reserve_desc(xs->rx, addr, len, flags);
> 	  -> if (xskq_prod_is_full(q))
> 
> Second part is redundant as in 1. we already peeked onto rx queue and
> checked that there is enough space to produce given amount of
> descriptors.
> 
> Provide helper functions that will skip it and therefore optimize code.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

