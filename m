Return-Path: <netdev+bounces-298818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xDftN6GXLGoJTgQAu9opvQ
	(envelope-from <netdev+bounces-298818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:34:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161B67D0F6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:34:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c92EFRws;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298818-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298818-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 794CB3116059
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD1364EAA;
	Fri, 12 Jun 2026 23:34:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF59262A6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 23:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781307295; cv=none; b=FsJXTqw20cuPvIE55rXyLQ72XZYDUE0D3K4LCp/3VeWep3J1j17kPqspJDr8VPhGKaAq+Rb33j2V49zSJ0UMe01oYBb3VSt69CqjJXa8htKLLQbcptdFQ9zPNu5ntibpu7VZzzxToR798eQ11uNABVRidRD9YWZpMNVcGAkQI/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781307295; c=relaxed/simple;
	bh=lT6kT342ohhm53XEx3YEsmCHr8IOTytEXglIvzgw62g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZjiD4xIerqTxMaTCnXlbdUyhypUflarRa26n5t/+N5VdZd0IT3oBzHajvc1GPJj33dIoA8pLPorISrEGUajoAVAcddhRnSSrv7tHOHHFdpIDXblNzMc+6NsZGfdb/IemKD79VtWQw3ruqNFQ71uWwuvLWPA9sjdauc8Q7vD0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c92EFRws; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224B91F000E9;
	Fri, 12 Jun 2026 23:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781307294;
	bh=lT6kT342ohhm53XEx3YEsmCHr8IOTytEXglIvzgw62g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c92EFRws0jfd6Lq03kDkK0VI1EKWkY03TrVbRWZ6yFoz2skx47ZjiiJ/w31KHi+OE
	 jGGPcYp0L9YtFLmRzHo1/Z1EaEis6JtI39tm6jSe8DnNna3XTchmI8lRbTtqs/ksh+
	 RDEqL4lQKXo4KTymYNBmMAO8QXAdeiN1mnsWgJUxHMyYWBx8DXB9w3KeddlQpWnX05
	 NPlbjHiTUsuJBhPJM1VNGUoAcn9BcN7oyIQnzAPKNGN5d6P18bKc80uCj0fwGL9pi+
	 sR3Vl8Hy7l22/i/yV4d5g3DdJ7VajPxKjc1JMJB4Gc6L/gTOxJICLn9QjfV0nKCZKN
	 UxtX1AiJ3acww==
Date: Fri, 12 Jun 2026 16:34:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 3chas3@gmail.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, tr0jan@lzu.edu.cn, zzhan461@ucr.edu
Subject: Re: [PATCH net 1/1] atm: svc: fix listen state corruption in
 svc_listen
Message-ID: <20260612163453.3d526c28@kernel.org>
In-Reply-To: <4af79c95e316b9a65a4c6302fc912a5944198b6b.1781031726.git.zzhan461@ucr.edu>
References: <cover.1781031726.git.zzhan461@ucr.edu>
	<4af79c95e316b9a65a4c6302fc912a5944198b6b.1781031726.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298818-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,gmail.com,lzu.edu.cn,ucr.edu];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:3chas3@gmail.com,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:tr0jan@lzu.edu.cn,m:zzhan461@ucr.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6161B67D0F6

On Thu, 11 Jun 2026 01:33:27 +0800 Ren Wei wrote:
> --- a/net/atm/svc.c
> +++ b/net/atm/svc.c

I'm going to send a series to remove svc.c shortly.
Could y'all please steer more towards code that has been used in this
decade?

