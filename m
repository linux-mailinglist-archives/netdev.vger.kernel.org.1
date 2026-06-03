Return-Path: <netdev+bounces-294724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jbxgG5kUIGpNvgAAu9opvQ
	(envelope-from <netdev+bounces-294724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:48:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A472063735C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=bIvKmAkn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294724-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294724-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2BA5301497F
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB04657CD;
	Wed,  3 Jun 2026 11:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808642A82;
	Wed,  3 Jun 2026 11:43:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486994; cv=none; b=iZm91ieAI4cHQDqaxbiuMGUn/2OmHT+KAgW+F0o7wtB7IJtpWy57bvYFxwJqyuuhkzFBD8pWYx2GsrNAFtlaaiDsJypdrFP8g/xqY2PwuSXeYsovyBdeM6m6Y55KaoHqM6HjR/27oxZM56TC/vobQjmNiCmoJlIi7XhfkS6bNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486994; c=relaxed/simple;
	bh=HKS3iP0Mxd2zfOaND1/X8FXgWwxedH3z+Ly75xdNnPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuITx4BbbzB3+HyWfR9Atlwtsdy1/eNfkd2n2twKi4lq/GDW5/CU+L3sWqqbQujE1J18zgeO/LiNqS9+YD5YE1HkSkiukbetG50bf4znRTAc51sFi6tL5RZkXD5zs3WKI0XOK2otEqVTJ1z+EvadfJqR7IVaKq2KvY/2ug63Zbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bIvKmAkn; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w2GTPiUTfd6wlnNIQDyyU2EA0vi5+a5iPIjIVVdlDgE=; b=bIvKmAkn2pMyqU6fnGhNINBuoq
	HMV1SwhbFMaQhsdvBpRef15UcKmJFd0ERdlebl8TtrCxpTPxsfjja9ItkiInhY8DLh1kFYflQ+3nY
	RyIsTpdflwpSUkKvHvg1yr0avW1hzwmJEIwAL37zKGTVAJGRGBeFJV3RSLeb/Rk18IGyLKclJp8fq
	Kkp+aROQyKE2GnD82miD+o+0MMTBzJfJuxTDuKPPUdqKxYbBy+yH8u1vdrzzegMJUYMtncC3iiyYC
	5rtcDgfq5fFcgR0pzqdGX7pIoRpjZiJbm+jR14bUwF5jzv6bsxsebAif5ixSvjExeWBNRcu11tVAD
	Aqp6+0tg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUk01-003hnE-2k;
	Wed, 03 Jun 2026 11:43:06 +0000
Date: Wed, 3 Jun 2026 04:43:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	stfomichev@gmail.com, kernel-team@meta.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: bnxt_en: suspicious RCU usage in bnxt_fw_reset_task() qdisc path
 in 7.1-rc6
Message-ID: <aiATI9qUfsL0jq1u@gmail.com>
References: <ah726OtFX-Qw3U-R@gmail.com>
 <20260602105451.18a7390f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602105451.18a7390f@kernel.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,meta.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294724-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:stfomichev@gmail.com,m:kernel-team@meta.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A472063735C

On Tue, Jun 02, 2026 at 10:54:51AM -0700, Jakub Kicinski wrote:
> On Tue, 2 Jun 2026 08:33:31 -0700 Breno Leitao wrote:
> > This looks like a regression from:
> > 
> >   850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the
> >                   bnxt_open() path"")
> > 
> > That revert dropped rtnl_lock() from the bnxt_open() paths and left
> > bnxt_fw_reset_task() holding only the instance lock around bnxt_open().
> > 
> > I can send a patch restoring rtnl_lock() around the bnxt_open() call in
> > bnxt_fw_reset_task() (re-taking rtnl before the instance lock, matching the
> > pre-revert code), but I wanted to report it first to make sure I am in the
> > right direction.
> 
> Yes, we need to revert the revert. Per my recent ethtool locking series
> netif_set_num_tx_queues needs rtnl_lock for now.

Ack and thanks for the direction. Do you want me to do it, or, is it
someone is already taking care of?

Thanks
--breno

