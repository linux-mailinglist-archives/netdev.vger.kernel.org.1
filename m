Return-Path: <netdev+bounces-260729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JdwBVNdnmmIUwQAu9opvQ
	(envelope-from <netdev+bounces-260729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:24:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AA0190DCC
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAE0F30D9838
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9706727F4CA;
	Wed, 25 Feb 2026 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp3ZRTXJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF127CB02
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986221; cv=none; b=Sh3TFVYERZvkEO6t7GDOWfCFtE7QeEoRDewAvb/kM71HIywNIBroUxOFlZ+4LE+xUVZZ4ybpZ0U00PRX9Oo6yXtPsqSuBFy0xt6E+1i3YAYaBm43osdDMH6parC6ToEPoujGvf92gSifPh9wEg3GUGbJgzu/rS4NAW5N2muCe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986221; c=relaxed/simple;
	bh=Qnx0WR8R5mNoZxUAOGkxdNrNv9gzPMJmma876hrxrb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgSLYRQv7ZRJ8FA2cXQ9P/T2bdWeY3EkDPQahvt0NuJa+hFxUj0SpKJhsOqv7i6O2dRD9YLqyMQ3wP088hM9essFB4U0oGGibvHyHhMfy0nUAlJbQ5kntXs+QAHpLkczauc9JlWUL3VgZtmG22/h3d7Ew3ORkd1/05p9bRMsZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp3ZRTXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32017C116D0;
	Wed, 25 Feb 2026 02:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771986221;
	bh=Qnx0WR8R5mNoZxUAOGkxdNrNv9gzPMJmma876hrxrb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fp3ZRTXJZ5pya1Ii6clAL7Zv90xaoAQgno7x9xgaMw4ykIESZN5p1wbl01ZcWEgSt
	 aetVlM0AAttXDwWAXhn8JX+s+qHqDbKXh9H80RoPaI35df9G+ucMoZHdRot5LItqo7
	 rAmNeRMVEAiUtJMWrObA/F0/Db104beKBSet8QXKF+PYCWs7iQQkZ25l/naGX4RizD
	 6vZubsEntChc3rMSo/Ge7uB9OozuUS9begkGcXAryDcgiTYblRuKiFS4vY98e57DJK
	 xAa2+AsOizuKhCQ0zE/dYkuz3iz+WEu8PiMwI9jL9V2QAGkWlFa4esAussCWCT38bG
	 AxAEadj1qg+MQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jiri@resnulli.us
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@nvidia.com,
	andrew+netdev@lunn.ch,
	tariqt@nvidia.com,
	matttbe@kernel.org,
	leon@kernel.org,
	daniel.zahka@gmail.com,
	mhiramat@kernel.org,
	skhan@linuxfoundation.org,
	pabeni@redhat.com,
	chuck.lever@oracle.com,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	horms@kernel.org,
	donald.hunter@gmail.com,
	mschmidt@redhat.com,
	corbet@lwn.net,
	saeedm@nvidia.com,
	edumazet@google.com,
	cjubran@nvidia.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [net-next,09/10] documentation: networking: add shared devlink documentation
Date: Tue, 24 Feb 2026 18:23:39 -0800
Message-ID: <20260225022339.998218-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223145557.248679-10-jiri@resnulli.us>
References: <20260223145557.248679-10-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260729-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,lunn.ch,gmail.com,linuxfoundation.org,redhat.com,oracle.com,vger.kernel.org,intel.com,davemloft.net,lwn.net,google.com,goodmis.org,efficios.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B0AA0190DCC
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "FYI"

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
documentation: networking: add shared devlink documentation

This commit adds documentation for shared devlink instances, which allow
multiple physical functions (PFs) on the same chip to share a devlink
instance for chip-wide operations.

> diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
> new file mode 100644
> index 000000000000..b2a1bd37564f
> --- /dev/null
> +++ b/Documentation/networking/devlink/devlink-shared.rst
> @@ -0,0 +1,89 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================
> +Devlink Shared Instances
> +============================

The underline length doesn't match the title. The title "Devlink Shared
Instances" is 25 characters, but the "====" lines are 28 characters. Should
these match?

> +
> +Overview
> +========
> +
> +Shared devlink instances allow multiple physical functions (PFs) on the same
> +chip to share an additional devlink instance for chip-wide operations. This
> +is implemented within individual drivers alongside the individual PF devlink
> +instances, not replacing them.

Should the documentation include a note here that shared devlink instances
are a workaround for legacy drivers, and that new drivers should have a
single devlink instance for the entire device?

This guidance appeared in multiple review discussions, particularly in the
V7 review where it was noted: "There needs to be a note here clearly
stating the the use of 'shared devlink instace' is a hack for legacy
drivers, and new drivers should have a single devlink instance for the
entire device. The fact that single instance is always preferred, and
*more correct* must be made very clear to the reader."

Without this context, readers might not understand when this feature is
appropriate to use versus when a single devlink instance would be more
correct.

> +
> +Multiple PFs may reside on the same physical chip, running a single firmware.
> +Some of the resources and configurations may be shared among these PFs. The
> +shared devlink instance provides an object to pin configuration knobs on.

[ ... ]

> diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
> index 35b12a2bfeba..f7ba7dcf477d 100644
> --- a/Documentation/networking/devlink/index.rst
> +++ b/Documentation/networking/devlink/index.rst
> @@ -68,6 +68,7 @@ general.
>     devlink-resource
>     devlink-selftests
>     devlink-trap
> +   devlink-shared
>
>  Driver-specific documentation
>  -----------------------------

