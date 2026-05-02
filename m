Return-Path: <netdev+bounces-283451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPB/FHo09mk5TAIAu9opvQ
	(envelope-from <netdev+bounces-283451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:29:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A27894B30C6
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E0E53001FA4
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922F738734A;
	Sat,  2 May 2026 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvp6Q5pS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569E386C30;
	Sat,  2 May 2026 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742965; cv=none; b=ZJwgjQPmJPuKCbIQriL5DrBBsY8J/YFXGDV2IwG/cfdi6A2EO+2Fmcrk9CIjxS4RbUfhehsX+OO5Wh+UXEnv6QZRkllR6TU21z/2Akk38f31VhbGKg4uBaN5gDMgF0tzz65zayyp8N1bxvbobwp0wYcdgg/lhgV7mPe/076j2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742965; c=relaxed/simple;
	bh=ftq2NTo4CCCcZGp16kODQPjcMmmyZ9VO5wcQNeix6wI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoD++oJl+y8J8gK5TYAReOrHd9qatI93oM4zQyVKz6eQZ1xxTNjCc42Mr6/Amfm894mZnpT6oN6lTpnvgMJmAfaaF27FCn2nM2luYj5zRlRTiwFa6+yEKZVN2y1mEshTmCAs+RKdkdECahup4i9xXuXfQ4Mf1lhpIldOoOtUo3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvp6Q5pS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11FDC19425;
	Sat,  2 May 2026 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777742964;
	bh=ftq2NTo4CCCcZGp16kODQPjcMmmyZ9VO5wcQNeix6wI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvp6Q5pS4d43mbHp/YRnBWWZJul6oHKUx+CQ0BuuCiysilBNgZ0WpdCB13CMfsAOt
	 12bcI7HzzN469jRDh8siugt/Qq5c7Jas3FQBWYCse+rA+ff4pf/zpl6y57Lj61m98Q
	 Aqriw6Yjt872g0hlbviW3N3WtFRPl13aWiHgUrpebw6KWLHuRb2LSlR1Zo6xhBXj7X
	 U2MD0BuC0iIbZD4Ur6usvRYksOudWt+uWuoT7PVpGRxTYKtYd+eyXmwzRz3zTfTM8S
	 dIJ78qYRa8doCVb7CYzO6WQSVonyNnvWHa81x/h3X1YP0jSfSNQK5zvP1i8W4MoDIh
	 7n7FmX4rojesw==
Date: Sat, 2 May 2026 10:29:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, poros@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 Prathosh.Satish@microchip.com, ivecera@redhat.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v7 net-next 3/8] dpll: extend pin notifier and netlink
 events with notification source ID
Message-ID: <20260502102923.79d491b1@kernel.org>
In-Reply-To: <20260430094238.987976-4-grzegorz.nitka@intel.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
	<20260430094238.987976-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A27894B30C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283451-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 11:42:33 +0200 Grzegorz Nitka wrote:
>  
> -int dpll_pin_delete_ntf(struct dpll_pin *pin)
> +int dpll_pin_delete_ntf(struct dpll_pin *pin,  u64 src_clock_id)

double space

