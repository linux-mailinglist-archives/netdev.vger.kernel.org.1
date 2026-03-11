Return-Path: <netdev+bounces-266430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OJfAFfWsGnLngIAu9opvQ
	(envelope-from <netdev+bounces-266430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:41:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C2925B0BF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A88307BDBA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161033164D6;
	Wed, 11 Mar 2026 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2E+4q12"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C72283CAF
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196884; cv=none; b=aG2oyKTlUE2/TFr/x2DezNMa3Qx2EmNu6tBOFN2mRLKJbOFQwiXMvI2/67RxkcK7M36BQJnbCyUO56VjI+4ko/hGPoHsCTHE9yPb8U8OyH/pQB3YDWqBPGd+pFKPhoMwRt8Pf5L9gI4nmPtcHTN8esyDJHgQnuejHcsC3BxeaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196884; c=relaxed/simple;
	bh=M1EcQp1XLqk0g4fpo3tk29vEJaN0An003A2269fsQBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A42qHHdMfeo9p23NT6MGivJyim7tlfBoqv3Ulr7BjvGjle/vmhgeH8Amt9qWJsf0QDasffs4UGenk2pHLixxCdqGEjIEx5QBjgHwhM5p0PGkTk8UuyTTpuYRvqH81nhgvFTJhjorPUmeTTo8RAkW9FuzIouGOGm1azXIV6w4xrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2E+4q12; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aea68839a5so3819175ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 19:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773196882; x=1773801682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAhnCuVTSGLgefKNC90vBK/sSxZ+X+LKRCCd98KKh1s=;
        b=R2E+4q12h1oJ6m6MYwyNHIMhduCuVI9+P5sez6L8sjN2BLjTNkeJ0R3Pju2OhvKH2e
         jN0j0C0pGxb6ZLhFFGdZYXRQgR6NhgG06EDxYddbrDr0051/Utr07+yPCY2LoIj+hc7F
         geGi4xyvrepKcPNZim7wo+0ZrKpzDsHQFq8zSQtHjvRfGg3+cOYJwRhSX567iu+vBueP
         yVb96+LghaP7npbcm8HaUgUmfK7sKrSW1wVNx1oxlOL27+b4J1fMF33u4YXkhOjRq94I
         vFEfzcvdrORhy3Q/3zrj5/kyoGyj3zu0SeS3KxOXYshMiRPGdybTzQ6xkh9gFtKzSfFv
         PrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773196882; x=1773801682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAhnCuVTSGLgefKNC90vBK/sSxZ+X+LKRCCd98KKh1s=;
        b=qcnLIPnDxM7ogaQVkaMraHoHO+sI8oBD88naOe4bKFomsFE6OtrNr1WQ7TVIPfzLvs
         UPywOp4Mate7MSS928gT+GVvaPkj2+zk5Ta7o+ySJ35BdIiDsJaY73UIZ8OAaFVtqbO2
         VicKO1lVYA5DeiOp0D5jq8oh88VSn6SwZffM7RacXncVBTITSnIs1pgXwUtUi7OUXbp5
         a5yLW0s+C93fsPOq9C8p+cMVwArjXcUl1YhlPzUK73LOEa2ToFKVkDWGFRu/Fbbqsrwr
         9jEJhXh+R/RxgfYf5Yc1/U0K/q+Zzve+cK/SJVgBhoaghIc1vVFQ83oxfHbEGpqHC51u
         cYeA==
X-Gm-Message-State: AOJu0YwZoh3jtrDozzeWnSrepHlY+zovYn+SqMXv5iquYG5ZweANARkR
	5XZdErYRbNiupG1tJ0BPttVHzUm1tj84jg91/vIa8EAvJN+yLIdSzKXY
X-Gm-Gg: ATEYQzzRqiP7OdI4ZkxvpeGR1DHDoTCzvt0Grf4JvPAkNtlBVKSTL5C2oyNVmGPmw/T
	d7aGVUfaD8s640LVIy/h2nXvN1cZ8QbmWZirNEwr9IHBRIjocMky1g8C7HCdtFDLbpa8ja7zX+k
	Iy20NHetP4+lJB5Bpyz9xxRC21c2Bv6HaJHWwWZeLSvtXCriv6yxN7Pv0B41WNRzCt/7ky1cfAK
	JOg4LhBTVUdMxdC9qLVFfnloQEHXvXy8BbU7Bhw5GJdC9MP6+8915DlK4LO9f+IHFbu8p/WEk+a
	5C/h/s98KcxiS/5BXrNL+Ij7KuADIy4nHDk/4oUz/SuwX6MGL6FBM7nMsxqUaJ+RBTxlCMIVwv2
	YdtC4QtOqDnhMEfTUQ7v/+HME1K+uiyHoNgrELyunCaiKQlBoDgPfcxWE1qfA7hujjhvY5EnKxV
	BHyze0fzt6X2Nko5ErtLshphycctc=
X-Received: by 2002:a17:902:dacb:b0:2ae:4d6b:b2c7 with SMTP id d9443c01a7336-2aeaeb920c8mr8563885ad.9.1773196882075;
        Tue, 10 Mar 2026 19:41:22 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34eaacsm5964695ad.49.2026.03.10.19.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 19:41:21 -0700 (PDT)
Date: Wed, 11 Mar 2026 02:41:14 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Liang Li <liali@redhat.com>
Subject: Re: [PATCHv2 net] bonding: fix multicast MAC address synchronization
Message-ID: <abDWSsK2Q3EybsG-@fedora>
References: <20250805080936.39830-1-liuhangbin@gmail.com>
 <83bef808-8f50-4aaa-912e-6ccdb072918f@redhat.com>
 <aJwO3vcLipougMid@fedora>
 <aL-iHkMmHKrnAeoW@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL-iHkMmHKrnAeoW@fedora>
X-Rspamd-Queue-Id: 59C2925B0BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266430-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Sep 09, 2025 at 03:42:30AM +0000, Hangbin Liu wrote:
> Hi Jay,
> On Wed, Aug 13, 2025 at 04:04:54AM +0000, Hangbin Liu wrote:
> > On Tue, Aug 12, 2025 at 10:42:22AM +0200, Paolo Abeni wrote:
> > > On 8/5/25 10:09 AM, Hangbin Liu wrote:
> > > > There is a corner case where the NS (Neighbor Solicitation) target is set to
> > > > an invalid or unreachable address. In such cases, all the slave links are
> > > > marked as down and set to *backup*. This causes the bond to add multicast MAC
> > > > addresses to all slaves. The ARP monitor then cycles through each slave to
> > > > probe them, temporarily marking as *active*.
> > > > 
> > > > Later, if the NS target is changed or cleared during this probe cycle, the
> > > > *active* slave will fail to remove its NS multicast address because
> > > > bond_slave_ns_maddrs_del() only removes addresses from backup slaves.
> > > > This leaves stale multicast MACs on the interface.
> > > > 
> > > > To fix this, we move the NS multicast MAC address handling into
> > > > bond_set_slave_state(), so every slave state transition consistently
> > > > adds/removes NS multicast addresses as needed.
> > > > 
> > > > We also ensure this logic is only active when arp_interval is configured,
> > > > to prevent misconfiguration or accidental behavior in unsupported modes.
> > > 
> > > As noted by Jay in the previous revision, moving the handling into
> > > bond_set_slave_state() could possibly impact a lot of scenarios, and
> > > it's not obvious to me that restricting to arp_interval != 0 would be
> > > sufficient.
> > 
> > I understand your concern. The bond_set_slave_state() function is called by:
> >   - bond_set_slave_inactive_flags
> >   - bond_set_slave_tx_disabled_flags
> >   - bond_set_slave_active_flags
> > 
> > These functions are mainly invoked via bond_change_active_slave, bond_enslave,
> > bond_ab_arp_commit, and bond_miimon_commit.
> > 
> > To avoid misconfiguration, in slave_can_set_ns_maddr() I tried to limit
> > changes to the backup slave when operating in active-backup mode with
> > arp_interval enabled. I also ensured that the multicast address is only
> > modified when the NS target is set.
> > 
> > > 
> > > I'm wondering if the issue could/should instead addressed explicitly
> > > handling the mac swap for the active slave at NS target change time. WDYT?
> > 
> > The problem is that bond_hw_addr_swap() is only called in bond_ab_arp_commit()
> > during ARP monitoring, while the bond sets active/inactive flags in
> > bond_ab_arp_probe(). These operations are called partially.
> > 
> > bond_activebackup_arp_mon
> >  - bond_ab_arp_commit
> >    - bond_select_active_slave
> >      - bond_change_active_slave
> >        - bond_hw_addr_swap
> >  - bond_ab_arp_probe
> >    - bond_set_slave_{active/inactive}_flags
> > 
> > On the other hand, we need to set the multicast address on the *temporary*
> > active interface to ensure we can receive the replied NA message. The MAC
> > swap only happens when the *actual* active interface is chosen.
> > 
> > This is why I chose to place the multicast address configuration in
> > bond_set_slave_state().
> 
> Do you have any comments?

Hi Jay,

Could you add some comments?

Thanks
Hangbin

