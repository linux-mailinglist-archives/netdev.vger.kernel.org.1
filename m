Return-Path: <netdev+bounces-273828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YApkOxN6zGnrTAYAu9opvQ
	(envelope-from <netdev+bounces-273828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:51:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69381373915
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38A1B3073DBA
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AE829D27A;
	Wed,  1 Apr 2026 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX9x10TL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2E13FEE
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008272; cv=none; b=bn+aHgsuRfveC3qyZQGqmAls268RPLxafwkPFpW7oQ6ToMWkBUXzniu2IpDsjyoyQAxIhGAftWYUf0fTZrtIg3LJIKIqeCpm15VKehtxXDjVT51GxShWSYsiusdl+As+xdzRZXLt27l27HEAopFFFSxqH4UGMaEyIAW2KxLB3VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008272; c=relaxed/simple;
	bh=q7VUBOhSMncR/g/BRF1P57/J1Z7UEn9TCx7hwTrkP9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvfNm0ovTzXDAQ+TKse2hylt/f2jqUaWe+kxRB1z3UXZfDw/kcxHvPRs5XPJh4RKdd8iRIvWA19X7J5uiKdIQoaUpvH2Zqie53Jl+yc2QzqtKvMcI7NXxlRLR0S+VSjhCXRSDnV2pSKaStS8pCn+Kb3R6e1gKYCk61CoLEoOtT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX9x10TL; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so4664373a12.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775008271; x=1775613071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6tuuYL0UZ6hlb3mMxVvw/iMPpkf63ZZk/aXRRgX7gW8=;
        b=EX9x10TLovmHqTOjdD6IbTh4g+sPY7RfCDZyGql2805Eq+pD7MyHivkiw/vtDD8vNk
         uK7wfS2oQf3E3FaW0K61LgF/zjsiUAllbMPU+XYBCJb5EyzARRjosvO05Xr091QW1OxR
         5BVc1DIymQVZwSzYxmA3WFFPTnSOd+hJqLKx/N+6lDc5ssnWtmd9eNL/3qm4i5NaNaEz
         XRwDFt+d2+T3miq8tf6x5OPkb6AoTyj4MhVmHsbbQTF8zg4tkGZyop4SSGa8ubk+ILqL
         PnCbDPtkuPWvQWF0Jsx2MSRFkYhkob2NiqImveAuL03duq3C3o+f6tMO2ew81hFrXyRk
         BCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775008271; x=1775613071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tuuYL0UZ6hlb3mMxVvw/iMPpkf63ZZk/aXRRgX7gW8=;
        b=XAQLDoBGU1NrdLbLZf1emKtYJPE5DzzU8ujmeWcC/78gRZD9mfqgBTFEVqkggIH/Cx
         I2mDdYqct8U5/++2lPraC6vufEoah2OyeA9P1tEe9ilgFhOz4PWy8S+suNcpIq6xMDEH
         LWBVj8mMU0cZc7ytzQN4BVXdsEg92Sx0z0OlYC88KFy+CXWk+cSBz+Kj7V4gPLfBNrln
         ZVdeXMhDKRLrnpSHuzpdzshPM4+mA73J0CXE0jKaPsZ3pTd7/pSNKgB+rc3J2MovaE2O
         MSh7wOAqiXXTBYCDUvWr8TEkrsgGYhqnImAlQ3KKTet+hh07Rvw5Vdw9XVdcqdurgyK8
         njNQ==
X-Gm-Message-State: AOJu0Yy7O9g5sGctskFg8+8HnnmBw23oPbJbFXaGx/T990JS6iUOnl8k
	srILxKwR2GpuT6i3O6oxiRbcIuU5g6nh9lNRyUrRA2ZiE0R7IJidDrCI
X-Gm-Gg: ATEYQzzl4jYNyIavAw10IahuSRj/M/a4ODHQg0vU33g29a17nVo4MCTUUCMZ5vlDzJ5
	0t7ENg2LmVoqy+FPZFXJ1qoeuasqq0+64wz4cS6CH78Fhf5AVyeYbMILtQRb6oA3fQzlZprKb+C
	9KE60s8h6iypdftk9CqnwVk4umjOdn+vGbAmKTBZwTgQROOchCesfE4N7YOBWN7FLK/I2pavi7O
	DU/rflbRsRvKxyu8vCOP+Gi1SING6WnDgp4mhDJAD1FUyX/m+W9GS5nELmV7g988FwAKwV2++Ot
	+VqMiCZsNZm6LeUqH2yHCNeH++svHrPDfs14e8wnZ3FuyqU1aJph3ZG/cckg2ORezSyjcxA6AJY
	F2cOzQS9u9Uay7sg9AmebZU8Nh10VC5JnG4yTMFqdrp1eMf9uANAds4NRNVf5y+f2QrZF4x0p79
	eUInoUejj6Q3aJJoGzz7CYOJhi1Es=
X-Received: by 2002:a05:6a00:330e:b0:7f1:4:66b with SMTP id d2e1a72fcca58-82ce8b327f7mr1798375b3a.44.1775008271133;
        Tue, 31 Mar 2026 18:51:11 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cd7d0410bsm3904816b3a.33.2026.03.31.18.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:51:10 -0700 (PDT)
Date: Wed, 1 Apr 2026 01:51:02 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net 1/3] bonding: set AD_RX_PORT_DISABLED when
 disabling a port
Message-ID: <acx6BqhwBSgUuE0F@fedora>
References: <20260226125331.28147-1-liuhangbin@gmail.com>
 <20260226125331.28147-2-liuhangbin@gmail.com>
 <942584.1772155015@famine>
 <aaEB6X6WPs7EBM33@fedora>
 <949695.1772167347@famine>
 <aaE32DlfrX9S5KNT@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaE32DlfrX9S5KNT@fedora>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273828-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[if3:email,if4:email]
X-Rspamd-Queue-Id: 69381373915
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Feb 27, 2026 at 06:21:20AM +0000, Hangbin Liu wrote:
> > 	Regardless, as above, the situation is generally equivalent to a
> > backup interface in active-backup mode: incoming traffic that isn't a
> > special case is dropped.  Normal traffic (bearing the bond source MAC)
> > isn't sent, as that would update the peer's forwarding table.
> > 
> > 	Nothing in the standard prohibits us from having multiple
> > aggregators in c/d state simultaneously.  A configuration with two
> > separate bonds, each with interfaces successfully aggregated together
> > with their respective peers, wherein those two bonds are placed into a
> > third bond in active-backup mode is essentially the same thing as what
> > we're discussing.
> 
> In theory this looks good. But in fact, when we do failover and set the
> previous active port to disabled via
>   - __disable_port(port)
>     - slave->rx_disabled = 1
> 
> This will stop the failover port back to c/d state. For example, in my
> testing (see details in patch 03), we have 4 ports, eth0, eth1, eth2, eth3.
> eth0 and eth1 are agg1, eth2 and eth3 are agg2. If we do failover on eth1,
> when eth1 come up, the final state will be:
> 
> 3: eth0@if3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
>     bond_slave state BACKUP ad_aggregator_id 1 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> actor_port_prio 10
> 
> 4: eth1@if4: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
>     bond_slave state BACKUP ad_aggregator_id 1 ad_actor_oper_port_state_str <active,short_timeout,aggregating> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync> actor_port_prio 255
> 
> 5: eth2@if3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
>     bond_slave state ACTIVE ad_aggregator_id 2 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> actor_port_prio 1000
> 
> 6: eth3@if4: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
>     bond_slave state ACTIVE ad_aggregator_id 2 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> actor_port_prio 255
> 
> 7: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>     bond mode 802.3ad actor_port_prio ad_aggregator 2
> 
> So you can see the eth0 state is c/d, while eth1 state is active, aggregating.
> Do you think it's a correct state?

Hi Jay,

Do you have any comments for this issue?

Thanks
Hangbin

