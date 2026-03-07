Return-Path: <netdev+bounces-264992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6mrvBvh+q2mwdgEAu9opvQ
	(envelope-from <netdev+bounces-264992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:27:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2615822956F
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 445D03020D5B
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 01:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5A92DAFD7;
	Sat,  7 Mar 2026 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhPOicbw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686BC2DA769
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846836; cv=none; b=V+oXw0jNlI5cASfXH733Mcf0+6fwN6S0YT6HUUDieNaTKyNXrFC5xhCSTawqO2SeZ06zPlF4FE3YcCS13oYC4ImQI/MpdFUTqvaNYlem788iR3ooVXLD3U8rSp8+oWbfHcRm5VwTdAEW+h7ZEgkpa/tkTuVUV6GMRK0S6o6SgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846836; c=relaxed/simple;
	bh=63+2mikLSv6El2mdrElgZ7skd2bM5hOJ8NnXiyxeesY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkPCYT0+0YKCPcLrLwDnvRLlL3pKhXIbE+7znL+jQrwtwmKE9LIMztqUyTJJbHjpe93LGTXsSSAVU2cwD8cUeOQTi5CL3vrRrSR60EH/OuYz7L/7h7JaSlD7P0mtE3ApnGTFpc2tuXMZubzTaYAldHWRca0uRzVA/o+2a0zJcjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhPOicbw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8297310ce0aso2231915b3a.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 17:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772846835; x=1773451635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dhsogTCHA7Y/An3JeHJX1RKI2H43I9Gsp7Uf5CnyRNM=;
        b=QhPOicbwHsxq8Eq8rJGXW+fzGLF3Bgarw/M9GU7UOz6ECzkP52skfxG1+JZUSJ3C7z
         S7eS1b3seBv851aIItPl7smYO4jXIpwVP2YMm+MpLeF2jEfHiq9JOTXPQ2mm9xhQM0C2
         TQUFh7k8t0ixcKotZtxpnHYBexDl16biLHr7nLtLo1QrWoPai40jSGiHKDz0UMeNeua/
         jm5PCfHrPmza6F8bvfrtjbnlg5cpQBtH7AMpSbDL+vSe25wGSuQgMfTaw8Eqk34oWiIX
         yQMRMxBnNDvrjgCs0KZrhmeh8ORTrJ8GPZKbvzMZSxtMCH8hVdxwEKf4IZaVajPJrEuv
         Ficw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772846835; x=1773451635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhsogTCHA7Y/An3JeHJX1RKI2H43I9Gsp7Uf5CnyRNM=;
        b=DaKwoSEUAq/WOj5g2SbS7F0swzVy2E2jIbk/fmuM6PInCJ8UsAEXnU4uRHAIP4Xqcw
         ir18zU5kz5QndI40ALO8AKlKn7N5POfxjY1jfVjPRpCs3msXI77+7sYaAlCzPT4fNER6
         j90MrSWmB0ujSqVsKdjOHtFLzh4zdAyc00IXcz3UABYRUn27S7L7OtFiTq6YPnrsYc7+
         ujO/l6+rJvLVmJnHgd23nCAVvVwfiXbRJfL3hujBB06Wu9EXDfj2oBZTJywebhSORN3C
         kVzSebehdkpx4odW4RTHD8X198GqU1hmZWXsp2MZbt8OV2Ra2gpCXJpdAO29PsVy1RJJ
         qtUg==
X-Forwarded-Encrypted: i=1; AJvYcCU6QopT8vEqX1ZFXSfErjpQyJNp2LRfWPgI52sOa9tY2sggVpdtas+7tJjjUB6epZE1hH9aMlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwpJDx7MLTUspeDhji0yRiNXj6eLPN4qeVZzTyNLex5cVeqNL
	BB/HNDvRrvzZ7xv5IGPQnCBGWgPWdLh9GrzuKRDzNyBEwPvJ/IZB3ggZ
X-Gm-Gg: ATEYQzy6RSobTTInLV/u+0MIWTHlfoyNxM0CasFV4yXXhfFCOchvNKb4c43hPilxUCh
	DrmuhWLgQDz7oGEjcAcMEZMQbO4NZWs7Rmdpq1SipitAY+ylsfLmHC9D0W63UCHAdUH31HbYxu2
	Rt9thPEWr7li2tyujN+QCcRNBHuUElGTNMz7cN76+1C8zhUBSCL8rRv3bsIy1Xo1uJnVytyeryc
	jdN/hi4A63Bacg0ajAWa5gZFfVkFqk3tvHJQVxaQO05XJc8EsNHL0J/Ne5dYti/1U2vORTo/tSC
	ylzFf70wf9HeF6jQJbg+U8K1moZ28G5fP6qYCArQWtyahHiaRYDGwhAwU/Ql9r7z59OoQVVNEnA
	EHUM/dlG+Sp4KKrJlwIeDcE7jVptzXHqVSew9f75NllHyIZib2cesuQGYQGOrzJI190aIygvcNx
	hBStVCKw4szWlGPr/bqH+9rPQYkI8=
X-Received: by 2002:a05:6a00:3d13:b0:81f:4dc7:d31 with SMTP id d2e1a72fcca58-829a2f6d393mr3710435b3a.33.1772846834619;
        Fri, 06 Mar 2026 17:27:14 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4638141sm3144325b3a.6.2026.03.06.17.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:27:13 -0800 (PST)
Date: Sat, 7 Mar 2026 01:27:06 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Tonghao Zhang <tonghao@bamaicloud.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Liang Li <liali@redhat.com>
Subject: Re: [PATCH net 0/2] bond: fix 2 link state issues
Message-ID: <aat-6piJ1updznEP@fedora>
References: <20260304-b4-bond_updelay-v1-0-f72eb2e454d0@gmail.com>
 <20260306162613.05a8ca6e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306162613.05a8ca6e@kernel.org>
X-Rspamd-Queue-Id: 2615822956F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264992-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.946];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 04:26:13PM -0800, Jakub Kicinski wrote:
> On Wed, 04 Mar 2026 15:13:52 +0800 Hangbin Liu wrote:
> > Here is the reproducer:
> > 
> > ```
> > ip netns add ns
> > ip -n ns link add bond0 type bond mode 3 miimon 100 updelay 200 downdelay 200
> > ip -n ns link add type veth
> > ip -n ns link add type veth
> > ip -n ns link set veth1 up
> > ip -n ns link set veth3 up
> > ip -n ns link set veth0 master bond0
> > ip -n ns link set veth2 master bond0
> > ip -n ns link set bond0 up
> > sleep 1
> > ip -n ns link set veth3 down
> > sleep 1
> > ip -n ns link set veth3 up
> > sleep 1
> > dmesg | tail
> 
> Are you planning to add a regression test? Or you think this is too
> much of a one-off regression? Just curious.. 

Hmm, I didn't plan to write a test case for this corner issue. But with your
reminder, may be I can add a common updealy/downdelay parameter test case.
I will add this on my todo list.

Thanks
Hangbin

