Return-Path: <netdev+bounces-269261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDu5Nl5Zu2m5iwIAu9opvQ
	(envelope-from <netdev+bounces-269261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:03:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE62C4A92
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3860230104B7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB69F2045AD;
	Thu, 19 Mar 2026 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYPNylgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BA72634
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773885784; cv=none; b=XsDsdEEaNzkLfUeSvejxoYvmRnDgTS5uESXF/X8ky0ktemB+C65RRPcK2r3D4VJumaUUlEe/vClcR8DpEJHlImUvDy4WYuLc9W54qkJ3VMr025cJyGpIP6eKdhdt9Rqr0MI6FemJ8ZijxuJhotPOv+pl5ieNg3qOAUO8KnpkVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773885784; c=relaxed/simple;
	bh=mKWLwc26UHp0QckseNliuojMeOSjfywUsmMLAQ3UG5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyaeL+F6q9Eba8YQA/5FZ6PJfUNFyl5fp4+CZPD94Na5NHSK0LhBGuXXgOW2B+7KBDW7Y5Z+8cOGoIularmXYk7yGAsEUlfJ4llHXdkv/vci6e+kA76duMcxT/KRc+uAd/GC/iPZ1RZ1UKdwG03V1s5+mLX6rIy6kAPUCESNGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYPNylgt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82a7539851fso86299b3a.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773885783; x=1774490583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ScNRNBIvzfApbX9SKu6wfVyGsSnrc3rMHZZR+kMrCFg=;
        b=kYPNylgt5whfitfGXzKtRHMm6LAwJxEgkurW+2kprjTnfLLaFez8AHq+f5UQHXPBKL
         E7/tGxbZWUoeR1s5pfE5P5cql37y/i6IPATX7qU1HBjBZimWdWetKRLCIFnqAR7xIzZA
         OMerkdsJjs38GT2ij5WyN7gWN7dqSCDYmIFIIeQ5G/h8oEciwCA8XWFv4FhyflXkI6b3
         akjQGRL/X8Mb8ubOUHoeJ3AtJa1WD+eiPbxh5M2PRMnorFa2/+kmjuw3PL50rN9KIfTA
         ib8dWcmBkdnjFsiQ5MOWHoYbIsVrJBDmW8XMEHTRyw/YUHwzay1SegbJ9vd2CiEsui8D
         3TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773885783; x=1774490583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScNRNBIvzfApbX9SKu6wfVyGsSnrc3rMHZZR+kMrCFg=;
        b=m41EfUD+3ppkSlJnHtLdaAxr0RlFJ1Z4bu/RYvelVDtqcYJFa+uN+vY4oKxvt8bLRf
         q6iiB9s8uorid+Dpn+b1Z909YbhER0ZusswlaELLxFSHybZxbIW44LqkjGe1HGQqUpgC
         fZAJTQnilG3vYmkrIflYYrr+ACoUISns6ndTOhiAncKqqA8W0qoK8qWtL14d/JKQZcL7
         97+c7r7hNT6ToZBLc0XjfCvpznvQkVtrRL5bDW+E91chNzsGH1JcDZ6xeilMA3/YiChz
         BYb3myxkUSAzhrFcBOLGdJULHWwhcYP3SaBc8myi/EA4TENY99awzE7ly4+5+e7XmErR
         wFVA==
X-Forwarded-Encrypted: i=1; AJvYcCXzCMXfVLGTaSSXpmI04Uq95Qql4wXQSZDKbO8Nj+q/t3sqMJ7daIywiEr1xZUw2zGDqna1jyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfsLnAyHV2AaXAJbWApye/qsl6TswSfuVDYb1nShj7q/x2/Itn
	gp7YIeHXa+HktD30crkakumozS/FZJqm5yweI4P7DaN1ZHln/FIWjTQz
X-Gm-Gg: ATEYQzxLFg5FMzh3h7Pza8Zqf9El06AV+47PP0ovZ1rKBsua0w1FGeRp+HRNo8E47QD
	DfriqZnDeixQn3EbSi05xcS6qE0QDefrKR8vL2vWHvwrM5OG1FO/CP/ua9W2fR/D8Xfh9xUQmal
	1GgdkFVdUhVn6g2smW4MPl2BTSwkfphhqhTp2uDzrKjY8rxx0ivNx89wVgYvGBmBKdwuDvK6JQU
	ja5dSC62Pi5cP0ErZ5wSMquEpzQDdalrGm3fFvJzgWrZVIjKrTOWFimQ5eUeJbCLBlZx816w7dZ
	+9ckZEWa4r1cBYEMnjIFRH4gsKIQ6nLnIcNDj3mnIYf7SlOULtm6qu+EqrTx3zIEGW4EEiKTykb
	ad9GovCek9Z93uY7bgatNQqXXDvzsD1UrFMUvI7xCEejAs87Ysa8qYat5q4MuMv1rC0A/HJl9wF
	EgZosYPjGup8GSgcR09WwZQOWHvBU=
X-Received: by 2002:a05:6a00:17a4:b0:824:36f8:346f with SMTP id d2e1a72fcca58-82a6ae213f7mr5040966b3a.25.1773885782857;
        Wed, 18 Mar 2026 19:03:02 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1ffbsm5577164b3a.43.2026.03.18.19.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 19:03:02 -0700 (PDT)
Date: Thu, 19 Mar 2026 02:02:53 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/5] net: add ndo_update_offloads for offload
 computation
Message-ID: <abtZTceO0xHKf1F3@fedora>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
 <20260316-offload_compute-v3-1-a5d4a07d86d3@gmail.com>
 <ablv266AIETvJwpP@krikkit>
 <abn8qFyE7pDuM4oN@fedora>
 <abs1VWLQVmXcWESQ@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abs1VWLQVmXcWESQ@krikkit>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269261-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.902];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48DE62C4A92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 12:29:25AM +0100, Sabrina Dubroca wrote:
> 2026-03-18, 01:15:20 +0000, Hangbin Liu wrote:
> > On Tue, Mar 17, 2026 at 04:14:35PM +0100, Sabrina Dubroca wrote:
> > > 2026-03-16, 12:26:09 +0800, Hangbin Liu wrote:
> > > > Add a new ndo_update_offloads callback to net_device_ops that allows
> > > > devices to compute and update their offload features during feature
> > > > updates.
> > > > 
> > > > This callback enables master devices to recompute their features
> > > > based on current slave device configuration. This is particularly
> > > > useful for bonding, bridging, team, and failover devices that need
> > > > to aggregate features from their lower devices.
> > > > 
> > > > The callback is optional and only implemented by devices that need
> > > > dynamic offload feature computation.
> > > 
> > > Maybe a dumb idea (and sorry to suggest this quite late in your
> > > submissions): since all implementations of this callback are only
> > > calling netdev_compute_master_upper_features(), does this need to be a
> > > new ndo, or could this be some kind of flag within struct net_device
> > 
> > Ideally all dev with IFF_MASTER should re-compute the offload. But at present
> > some master devices do have this flag, or have their own offload
> > implementation.
> > 
> > Do you mean add a new private flag, like IFF_RECOMPUTE_OFFLOAD? For the second
> > parameter, maybe we can pass false for bridge specifically.
> 
> I hadn't thought specifically about where to store that flag. As a
> private flag, why not (this should be internal to the kernel, so not a
> uapi flag like IFF_MASTER), but priv_flags is marked as "hotpath" now,
> so maybe something similar to needs_free_netdev or
> netns_immutable. Either way, then devices are free to do their own
> magic, or request the core to call
> netdev_compute_master_upper_features() for them in some common
> locations. Does that makes sense?

This looks better than private flags. I just feel this magic hide a little
deep for a common master feature.

Thanks
Hangbin

