Return-Path: <netdev+bounces-273262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PxkKGylymmx+gUAu9opvQ
	(envelope-from <netdev+bounces-273262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:31:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC09235ED40
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82AE93019DBA
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E5377034;
	Mon, 30 Mar 2026 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="N1zrrHC5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20512F25F0
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774887582; cv=none; b=iCDehPoAl3NvsG9msBB+z1XhSpjhv/Z1SGAMXfWs7q5s97yw7wvuGtPziWNZt1ZVsJcbgDHEAAozLH51BJX4o/c/80wxLJsUXKggQFtwLRpNK3xFtYp54c6znhYe4LUPUk06bc2S+MVuDeA50udkoBipKk1lNntkmmHVovRSECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774887582; c=relaxed/simple;
	bh=FTuPN9pkuRk/knUlmKwpvTYIByq38R8qrglue9xcxxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZNYH3TIYnIxl1Mp/KBCQDodCFWbeNNNJPRsvvmJu65QAu4IdH3brnn1pV6ReguN8fCOWTxGIOjaTsLCeWtexyJjRgH9OXT6hTz6d+TE0JAwbNHUsqGcN+i6bye7Ev8C9ixAdJmgIlUQ0tVl3KI6ezMgrbu48TQzSVQjM93F3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=N1zrrHC5; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fkwxG6x6Fzgc5;
	Mon, 30 Mar 2026 18:02:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1774886530;
	bh=QH+ghypWdt87NimbK9S9Ph50XXZxDv7xSO3Sn1QWNq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1zrrHC5/XlFGcLq2WXkDxiJWkywxl5OC7LjS3jxwhKkKNJfWNIZaZo48glpkXnAj
	 eUX/PgGy83Euh+3N6M3IfEQa0QKaLBSlQaxWdbISCcvyWU7xo97xYoQp/rSHfX5DA6
	 d5Q96ooHGB8ZXGWcm2m04q2cZIvwLDu8P7ZWEo94=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fkwxF0FL0zhFP;
	Mon, 30 Mar 2026 18:02:08 +0200 (CEST)
Date: Mon, 30 Mar 2026 18:02:05 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>, 
	John Johansen <john.johansen@canonical.com>, Georgia Garcia <georgia.garcia@canonical.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v8 01/12] lsm: Add LSM hook security_unix_find
Message-ID: <20260330.ie1eth0ex9Pa@digikod.net>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
 <20260327164838.38231-2-gnoack3000@gmail.com>
 <CAHC9VhRktViRp_U3ZAvo2e7vbjUd6RZb-y8+YPXhtLpt7hsXYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRktViRp_U3ZAvo2e7vbjUd6RZb-y8+YPXhtLpt7hsXYg@mail.gmail.com>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.89 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273262-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,namei.org,hallyn.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[digikod.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,paul-moore.com:email,digikod.net:dkim,digikod.net:email,digikod.net:mid,maowtm.org:email]
X-Rspamd-Queue-Id: AC09235ED40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:55:58PM -0400, Paul Moore wrote:
> On Fri, Mar 27, 2026 at 12:49 PM Günther Noack <gnoack3000@gmail.com> wrote:
> >
> > From: Justin Suess <utilityemal77@gmail.com>
> >
> > Add an LSM hook security_unix_find.
> >
> > This hook is called to check the path of a named UNIX socket before a
> > connection is initiated. The peer socket may be inspected as well.
> >
> > Why existing hooks are unsuitable:
> >
> > Existing socket hooks, security_unix_stream_connect(),
> > security_unix_may_send(), and security_socket_connect() don't provide
> > TOCTOU-free / namespace independent access to the paths of sockets.
> >
> > (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> > This requires another path lookup. A change in the path between the
> > two lookups will cause a TOCTOU bug.
> >
> > (2) We cannot use the struct path from the listening socket, because it
> > may be bound to a path in a different namespace than the caller,
> > resulting in a path that cannot be referenced at policy creation time.
> >
> > Consumers of the hook wishing to reference @other are responsible
> > for acquiring the unix_state_lock and checking for the SOCK_DEAD flag
> > therein, ensuring the socket hasn't died since lookup.
> >
> > Cc: Günther Noack <gnoack3000@gmail.com>
> > Cc: Tingmao Wang <m@maowtm.org>
> > Cc: Mickaël Salaün <mic@digikod.net>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  5 +++++
> >  include/linux/security.h      | 11 +++++++++++
> >  net/unix/af_unix.c            | 10 +++++++---
> >  security/security.c           | 20 ++++++++++++++++++++
> >  4 files changed, 43 insertions(+), 3 deletions(-)
> 
> This patch doesn't look like it changed significantly in this
> revision, is there a reason you dropped the tags from Georgia and I?

You'r right, the patch didn't change at all. I added Georgia's tag in my
-next branch for the previous version, I guess Günther forgot to add it
for this version, but I updated my branch with the same tag, so it's
still there.  Thank you both BTW!

I just included a one-line fix because of the m68k warning, we'll see if
it works as expected, and we should be good to go.  It would be nice to
have John's feedback though.

