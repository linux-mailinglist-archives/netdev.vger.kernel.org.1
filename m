Return-Path: <netdev+bounces-299537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GZo4Kt0qMGpgPQUAu9opvQ
	(envelope-from <netdev+bounces-299537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:39:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F798688765
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:39:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SwKQh4ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299537-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299537-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E83C030E3FB9
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3897440E8D8;
	Mon, 15 Jun 2026 16:33:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6440E8C0
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:33:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541205; cv=none; b=aJfVya8WAGAvq65yxNyfKIOm3dyixMWJwbzM7FBHe001ZYDVI8Ksl6eUfePFf004mntb2Oq8vboQrgFwHVoECWVXEQa2zWGJrEQmp7EiUi/5Z9xawq2eN2oV7lAevqKVrmzwoNhLi5uz+q+DK2igs4DkmZtTgBZUW1TIgOSu+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541205; c=relaxed/simple;
	bh=KEvEJAUO+Rj1pnYOX1+VULsP0WChqt2c3f5AyGpbccs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElO8Xcv9Z7Rw3zZE/HIxuq2FmHf/vQqQyMELmTt5G4xjFyisk+7LK1eLIfRX0rmXkz/vnEoSiZOMGCRTrehjMyDIVCjWWC5StS1EkC9+BKwR+fH+zADAY/luJry6u412NDpvCH1ZwyDzBlTEaL+Hw8bmcrs9nLeG/OEd31S99Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwKQh4ch; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BC61F00A3D;
	Mon, 15 Jun 2026 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781541204;
	bh=KoTrRj3xD7Faetz+VDaOCE667oOPl1IqOmQuaXN7tjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SwKQh4chRlqRviR3p4lVvkOSNwWW7so/B7XoqcUrbFIL2Vdj7mMdfmP/qnr6CHURq
	 aCnGiwIg+tqtHOIx1+fo1MlmWLKACk8q/fJvoFUFugP5KnwoOI1AwcC7nncyNqNZir
	 JPu0l3oO3dAHdZsT1+jZVaJCikeh7brmMW0N4J0ChgFBM9g0jfJMnOqOmcNeX9isZ6
	 TzMy2KOKgXmrh71QuZWJsHba7A6pbCM5LkJMsZDQKPkavHjgd8vg8WzLz3vysrPEs/
	 tfaxI2kKVnJ0NFAsvScqmxFXLG8tZHUj2FkBfeu/vpzdPfyJVRq1ZjtMedgBbp6IuS
	 efvEl0sD0juFg==
Date: Mon, 15 Jun 2026 17:33:19 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, 3chas3@gmail.com,
	mitch@sfgoth.com, linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org
Subject: Re: [PATCH net-next 0/9] atm: remove more dead code
Message-ID: <20260615163319.GO712698@horms.kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260613201032.77274-1-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299537-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:3chas3@gmail.com,m:mitch@sfgoth.com,m:linux-atm-general@lists.sourceforge.net,m:dwmw2@infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F798688765

On Sat, Jun 13, 2026 at 01:10:23PM -0700, Jakub Kicinski wrote:
> Commit 6deb53595092 ("net: remove unused ATM protocols and legacy
> ATM device drivers") removed a good chunk of old ATM drivers.
> Our goal going forward is to limit the ATM support to PPPoATM
> used in ADSL deployments.
> 
> A recent burst of AI generated fixes for net/atm/signaling.c and
> net/atm/svc.c made me look closer at the remaining code. PPPoATM runs
> over permanent virtual circuits (PF_ATMPVC) with a statically
> configured VPI/VCI. We can drop switched virtual circuits (SVCs)
> and user-space signaling (atmsigd) support. While digging around
> I noticed a few more obviously dead pieces of code.
> 
> Annoyingly, I have applied one "fix" to QoS config which will
> now make net conflict with this series :/
> 
> Jakub Kicinski (9):
>   atm: remove AAL3/4 transport support
>   atm: remove the unused send_oam / push_oam callbacks
>   atm: remove dead SONET PHY ioctls
>   atm: remove the local ATM (NSAP) address registry
>   atm: remove SVC socket support and the signaling daemon interface
>   atm: remove the unused change_qos device operation
>   atm: remove the unused pre_send and send_bh device operations
>   atm: remove unused ATM PHY operations
>   atm: remove orphaned uAPI for deleted drivers, protocols and SVCs

There is a compile time nit on patch 4/9.

  ../net/atm/resources.c: In function ‘atm_dev_ioctl’:
  ../net/atm/resources.c:227:20: warning: variable ‘len’ set but not used [-Wunused-but-set-variable=]
    227 |         int error, len, size = 0;
        |                    ^~~

It might be nice to clear that one.
But overall this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


