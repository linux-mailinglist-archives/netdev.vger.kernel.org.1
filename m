Return-Path: <netdev+bounces-300130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OhDyObuAMmoK1AUAu9opvQ
	(envelope-from <netdev+bounces-300130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:10:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4661A698DA5
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:10:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fmK4Syly;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300130-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300130-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A552531DB383
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD503BBFCF;
	Wed, 17 Jun 2026 10:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0603A542F;
	Wed, 17 Jun 2026 10:50:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693423; cv=none; b=I59uCvUV0G1OW30ImsJIvEtw5OXdGVjJBcd5TDqC9wGxAXUnNgWjwjcipT47A3CsOriDtWI1xBeKUjnFPmMLLpvhk/LmFx1bORzXU5Yyb8EQGrhJwZhaBhPye4bq/8end84iow51gN5M4Ttq+Rt8Fx81XQsG6LfPoJw+1evTnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693423; c=relaxed/simple;
	bh=9pPBkO3gc9N/jyqyq7AGK1UiVjHQGxA2rU0Oet/CGjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqRxhi+y21gn3s3OCgUz0z/kLqmr6DMsxNxyyEXpYZmSsBJzLNpmeSI/M/QkXttGWPsjHd0+HdMsI2cu4BysmYUGECVOiIeb7kWDiQUMKMwZn8Z4Xfo85KuucvF2N0l0o6E8Wwzpq/yUVVrrmyUCWTdttysJBBvIo5nYQ0WQOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmK4Syly; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131CE1F00A3A;
	Wed, 17 Jun 2026 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781693422;
	bh=TcgwyOhuccTDCxyM2IFtavwgGWUzSYEdO4vCBnknHj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fmK4SylybLAYzLx+5Szg6wczbL87zqr6Lntq9LVbE9LWfRg/lsV+VZlW+lmr/HL3l
	 AtV6+yCBeyu6DQuy/t3wotcVCE/VM+Zo7uEBoqaXVPez3SOLcK7C37oVw/ArUffRkw
	 xY7rDxy0lJCeZN7pm4vMr2D6XgZfKuwblHWjbdeg/qhE4PnKnprlc3do92NWE/O2CW
	 kfLD9Ox6cCO6Fgc2UnB0DHAETrpzLEFfyNhlMsVYwyDqwsrMHnOKGYVcjqhNZk8a4f
	 b97EbDTbPbOh6lYm6raMQ12KGmJ84YDaZayLo3UJJH4tJ0L4bwmAcD/R3piuU4GFgs
	 XkYIvB3kD3T7A==
Date: Wed, 17 Jun 2026 11:50:18 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: kuba@kernel.org, joel.granados@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
	niecheng1@uniontech.com
Subject: Re: [PATCH net] net: llc: make empty have static storage duration
Message-ID: <20260617105018.GC827683@horms.kernel.org>
References: <20260616064053.690154-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616064053.690154-1-guanwentao@uniontech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300130-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:guanwentao@uniontech.com,m:kuba@kernel.org,m:joel.granados@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhanjun@uniontech.com,m:niecheng1@uniontech.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,uniontech.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4661A698DA5

On Tue, Jun 16, 2026 at 02:40:53PM +0800, Wentao Guan wrote:
> Make empty have static storage duration (like net/sysctl_net.c does) to
> avoid a potential use-after-return and keep consistent with
> __register_sysctl_table @table 'should not be free'd after registration'.
> 
> Fixes: 73dbd8cf7947 ("net: Remove ctl_table sentinel elements from several networking subsystems")
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

Reviewed-by: Simon Horman <horms@kernel.org>


