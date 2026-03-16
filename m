Return-Path: <netdev+bounces-268191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNJ2BCgmuGnhZgEAu9opvQ
	(envelope-from <netdev+bounces-268191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:47:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 868F529CB8B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60D4A3047AFA
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDD22D94AF;
	Mon, 16 Mar 2026 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJR2C+AS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213439FCB9
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675739; cv=none; b=ZpYqgKfvkL06YiLEskw89sJGzcaYgA478032tnOhtYyHA/it/+il6UP3ct4aUHFmdqbtJrgh+5999hXbsL2hT1SQuMy3ZB4Y/o8P4uVjE0fFwaWwvKIMgTI2aDWlmLar53bN/GZJV9wHuc2idXQZawa97d0aM0fd5zvNaSPKqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675739; c=relaxed/simple;
	bh=QeloVI3GCvB+oP5Ou2Ggfp8PjFcaah3ZP58qnd1PRB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbHCDKloMkU4HrjWKCKWKwgSbzJ1qaK12oP78t6M1KrArXHhmsFlX7Faa9QeEtN+xRE9+KsNmokssuyCsXGsJQkBMX5UxGw9eQ1Rp3TV55nd5r9eNJO63LtUdfMpS6r7jjJrbfwzMeBYZW4Bwrj89mCx3pGlE1hchKU6I0O+5RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJR2C+AS; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so2999920eec.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773675737; x=1774280537; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/qqWY9do+CO4GN8l/EJ8bGpmKe5IhxcGCcha5vVMyfs=;
        b=XJR2C+ASr7ulCgn2II/g7Xbe+qndBjTz0snyyLFnrt1zqHpDz28K0TUPnE/UXHd+db
         5GqbykNpaRh14wR20ixhAs0gZ7otDIfJTTTxVwr5gkJVBOBJzrxhb6zA8pn795ZLmHA9
         MzP25nGVDOTEOmCmpiFeUZ77DnqCeuc6sexVQEje5ZC7kEOZSD6cgvJOmDeJCNXmF+1e
         CkQ2/yHmA2jJO0IoIf3OWMXtZa3Z4l3248svoMIT9XW65XXkdPwfK4xLyWH/uQCIWnDx
         BEQW5SKMcTkbjofqYg+6NF9ZCKZsh7Xa2pMTAvbvoR+af2nFXs89cQ3x60c2fph/nGvD
         WZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675737; x=1774280537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qqWY9do+CO4GN8l/EJ8bGpmKe5IhxcGCcha5vVMyfs=;
        b=gyDDdBmxxbeaDK7/47DxAaDb7J1XFWbn+tPuZKv7Sph8j9RHoGtTDC7AN1qPSBuFxf
         p0Nb5pZjKrTyPdvD0bYY1Yga+48yM6zwmvxXdvoCbRdxiTy31igf6cOkaqVewrm4hNvM
         huxHfpWFeqDOv1hLFQjy492jgk4eCmlS2BfM3P5px3MQ4vnlj6xbrfqvO8JT4JVni2fe
         uWbmSdLew98eQIUoqOydqYtOflQo9r6kbGoZQS7P71AZPDgQz3n9wfGSG0tznlutJqBh
         7wnN+AUPhBKoR2CIv91nZA45H8SCDk7P8+Knzxc9oo5TKbJaBcARxaquNuKOlHKAjl4/
         UFiA==
X-Gm-Message-State: AOJu0YyQ1N4Y+m786XasXGHYnrCSinLGJrwU2slKOIET36ZRwGiUhpmP
	po3inxbb+bPXkKx/a1fH7nvlAojfDGw1xeo+ZMtVEud7d20/oDQvVmg=
X-Gm-Gg: ATEYQzwu30kEl2BYFsNIHv8qKrPUxQCPNQWC6jyiGZho2iU/fDnt5tO10PU0sX9rfp7
	7GHNrMrINDS0sUD8rhS4q91s2p2hBLsBF1Q1tIYxaHDnVGv3yrdQG0WlKjONKoVjM7cMaQv45vh
	YduBGGhr9xTAQDlLxkeD24gAn7ERagKG0JrLvPTY+ruglQMBVNGEGOU4U0ZlR1JwyG0SjwREBbK
	ku3NyNr5q5Um7gIyvuwlhtE82te1a6Lald2Y414eKgJJv01/iAyA3ovpURC4pVXAc31XqpjM5Vx
	Eyqi406K9WXVorrxaWk9F9HqdLSZTv/9964eVT0xzvNIX2JywJ9HAuC8LhVDe+icHwwTRi9JhWG
	ytG4Keqqym7+a43AWZPfUuaSghtcQFW6n/w6GJ/dB1e7THEq+7uhlJyplEcmq2imG9CQZeO/5oe
	NyVdi938NByI+9eBtHpGC2O6Zc847n+zK9jQVn4wA/SOc7mFQAOFwmvcb5TDwzVqmaObpTi4b1/
	p8YA+NB+pz+lChykg==
X-Received: by 2002:a05:7301:1f0e:b0:2ba:6458:b325 with SMTP id 5a478bee46e88-2bea5585cb6mr6444801eec.23.1773675736682;
        Mon, 16 Mar 2026 08:42:16 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0c12fb4a8sm5891040eec.0.2026.03.16.08.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:42:16 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:42:15 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 05/11] mlx5: convert to ndo_set_rx_mode_async
Message-ID: <abgk13yDjGO1UTlV@mini-arch>
References: <20260313145113.1424442-1-sdf@fomichev.me>
 <20260313145113.1424442-6-sdf@fomichev.me>
 <10534fecb1be59b3468767d291c42ab502f85af2.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10534fecb1be59b3468767d291c42ab502f85af2.camel@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268191-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 868F529CB8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/13, Cosmin Ratiu wrote:
> On Fri, 2026-03-13 at 07:51 -0700, Stanislav Fomichev wrote:
> > Convert mlx5 from ndo_set_rx_mode to ndo_set_rx_mode_async. The
> > driver's mlx5e_set_rx_mode now receives uc/mc snapshots and calls
> > mlx5e_fs_set_rx_mode_work directly instead of queueing work.
> > 
> > mlx5e_sync_netdev_addr and mlx5e_handle_netdev_addr now take
> > explicit uc/mc list parameters and iterate with
> > netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.
> > 
> > Fallback to netdev's uc/mc in a few places and grab addr lock.
> > 
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Cc: Tariq Toukan <tariqt@nvidia.com>
> > Cc: Cosmin Ratiu <cratiu@nvidia.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  5 ++-
> >  .../net/ethernet/mellanox/mlx5/core/en_fs.c   | 33 ++++++++++++++---
> > --
> >  .../net/ethernet/mellanox/mlx5/core/en_main.c | 16 ++++++---
> >  3 files changed, 40 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > index c3408b3f7010..091b80a67189 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > @@ -201,7 +201,10 @@ int mlx5e_add_vlan_trap(struct
> > mlx5e_flow_steering *fs, int  trap_id, int tir_nu
> >  void mlx5e_remove_vlan_trap(struct mlx5e_flow_steering *fs);
> >  int mlx5e_add_mac_trap(struct mlx5e_flow_steering *fs, int  trap_id,
> > int tir_num);
> >  void mlx5e_remove_mac_trap(struct mlx5e_flow_steering *fs);
> > -void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
> > struct net_device *netdev);
> > +void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
> > +			       struct net_device *netdev,
> > +			       struct netdev_hw_addr_list *uc,
> > +			       struct netdev_hw_addr_list *mc);
> >  int mlx5e_fs_vlan_rx_add_vid(struct mlx5e_flow_steering *fs,
> >  			     struct net_device *netdev,
> >  			     __be16 proto, u16 vid);
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > index 9352e2183312..3469b5a197db 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > @@ -610,20 +610,31 @@ static void mlx5e_execute_l2_action(struct
> > mlx5e_flow_steering *fs,
> >  }
> >  
> >  static void mlx5e_sync_netdev_addr(struct mlx5e_flow_steering *fs,
> > -				   struct net_device *netdev)
> > +				   struct net_device *netdev,
> > +				   struct netdev_hw_addr_list *uc,
> > +				   struct netdev_hw_addr_list *mc)
> >  {
> >  	struct netdev_hw_addr *ha;
> > +	bool unlock = false;
> >  
> > -	netif_addr_lock_bh(netdev);
> > +	if (!uc || !mc) {
> > +		uc = &netdev->uc;
> > +		mc = &netdev->mc;
> > +
> > +		netif_addr_lock_bh(netdev);
> > +		unlock = true;
> > +	}
> >  
> >  	mlx5e_add_l2_to_hash(fs->l2.netdev_uc, netdev->dev_addr);
> > -	netdev_for_each_uc_addr(ha, netdev)
> > +
> > +	netdev_hw_addr_list_for_each(ha, uc)
> >  		mlx5e_add_l2_to_hash(fs->l2.netdev_uc, ha->addr);
> >  
> > -	netdev_for_each_mc_addr(ha, netdev)
> > +	netdev_hw_addr_list_for_each(ha, mc)
> >  		mlx5e_add_l2_to_hash(fs->l2.netdev_mc, ha->addr);
> >  
> > -	netif_addr_unlock_bh(netdev);
> > +	if (unlock)
> > +		netif_addr_unlock_bh(netdev);
> >  }
> 
> Rather than the lock/unlock dance, wouldn't calling the same function
> recursively (guaranteed once) look cleaner:
> 
> if (!uc || !mc) {
>         netdev_addr_lock_bh(netdev);
>         mlx5e_sync_netdev_addr(fs, netdev, netdev->uc, netdev->mc);
>         netdev_addr_unlock_bh(netdev);
>         return;
> }

That looks much better indeed, thanks!

