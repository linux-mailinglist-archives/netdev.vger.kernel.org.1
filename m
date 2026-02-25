Return-Path: <netdev+bounces-260728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KML6BqNdnmmIUwQAu9opvQ
	(envelope-from <netdev+bounces-260728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:25:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E7190DF3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC7F302B38E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7F27F4CA;
	Wed, 25 Feb 2026 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy//YZ2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3991119D891
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986219; cv=none; b=pfY/5wopfZckstruRgJRv9RugVyCuFeki0IhAGr2IKduE0HwdmxFEsAZpOXvj+Ha390ELSdt+gYBeF3E3hCF1OFsqi+UnJDw2ER+QRMJTYp513e+w28afbhJpJ2Hu7bhKQUo3MlYRPqP8RmWkTTRbAi/svewdXv4TFXonimhyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986219; c=relaxed/simple;
	bh=x1ymoDPLhwci/6uYGOuuFIDrfEIVKrMaeewtndWA07g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfhuUGS0yBtfqeTPj3xz+3T9AmeiUL4cb6zUibRMt36j+w3zspwk5gVRCtrVfxx3D4xOVX7QHOtwi4PaRiTou7l0KJe4ASHrt8pQEU/VaYsGQRjxchfBLdRdQvJqZzNgPRiGgaw3hUwD7mnVG6ZMYyWCgt+rF2YiBAyF4BFNCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy//YZ2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0C5C116D0;
	Wed, 25 Feb 2026 02:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771986218;
	bh=x1ymoDPLhwci/6uYGOuuFIDrfEIVKrMaeewtndWA07g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dy//YZ2ViCn9bAz3Tz6QJWR5wpCkX7nrqXz1o5J3qqtif9MwCpYfTHGzqRDqMujnz
	 neMAD/K9lgspZEKvTbuHJHJeYQD+Kc9qT/Pj7rywra0V2+1QkGbgNNdViZgem8cWaE
	 G7Vvtzi87Wf0bwz2bwJt7pA/hU2TkI1+mZjuw7Ru2MxWP9Qah64FWpvifzIfu/tBpe
	 lIP/JWtikR9Vf/dU9GHXc7NQqsPjWERb1iEmhFBnLoUB2hNhPLBDzerKbEYPl5OQx7
	 /5Cy3rK0V4uD+dwuq9qrJVH5yOWYUUrA6msasoMl6Uh806mcw915UnioRwllzkL0Ni
	 H9IrenFVYnv4Q==
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
Subject: Re: [net-next,08/10] devlink: introduce shared devlink instance for PFs on same chip
Date: Tue, 24 Feb 2026 18:23:36 -0800
Message-ID: <20260225022336.998151-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223145557.248679-9-jiri@resnulli.us>
References: <20260223145557.248679-9-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260728-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,lunn.ch,gmail.com,linuxfoundation.org,redhat.com,oracle.com,vger.kernel.org,intel.com,davemloft.net,lwn.net,google.com,goodmis.org,efficios.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 834E7190DF3
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "FYI"

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
devlink: introduce shared devlink instance for PFs on same chip

This patch introduces a shared devlink instance for managing resources
shared among multiple PFs on the same physical chip. The implementation
uses reference counting to manage the lifecycle of these shared instances.

> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index 45dec7067a8e..e97ee09af5d6 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -1647,6 +1647,12 @@ void devlink_register(struct devlink *devlink);
>  void devlink_unregister(struct devlink *devlink);
>  void devlink_free(struct devlink *devlink);
>
> +struct devlink *devlink_shd_get(const char *id,
> +				const struct devlink_ops *ops,
> +				size_t priv_size);
> +void devlink_shd_put(struct devlink *devlink);
> +void *devlink_shd_get_priv(struct devlink *devlink);
> +

[ ... ]

> diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
> new file mode 100644
> index 000000000000..8bd8f4b506f5
> --- /dev/null
> +++ b/net/devlink/sh_dev.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#include <net/devlink.h>
> +
> +#include "devl_internal.h"
> +
> +static LIST_HEAD(shd_list);
> +static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
> +
> +/* This structure represents a shared devlink instance,
> + * there is one created per identifier (e.g., serial number).
> + */
> +struct devlink_shd {
> +	struct list_head list; /* Node in shd list */
> +	const char *id; /* Identifier string (e.g., serial number) */
> +	refcount_t refcount; /* Reference count */
> +	char priv[] __aligned(NETDEV_ALIGN); /* Driver private data */
> +};

This isn't a bug, but the flexible array member priv[] is missing a size
member annotated with __counted_by(). Jakub Kicinski noted this in the V7
review:

  https://lore.kernel.org/netdev/20260202194946.64555356@kernel.org/

  "size member annotated with __counted_by() is missing here"

You acknowledged this ("Will add.") but the annotation is still missing
in the current code.

> +
> +static struct devlink_shd *devlink_shd_lookup(const char *id)
> +{
> +	struct devlink_shd *shd;
> +
> +	list_for_each_entry(shd, &shd_list, list) {
> +		if (!strcmp(shd->id, id))
> +			return shd;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct devlink_shd *devlink_shd_create(const char *id,
> +					      const struct devlink_ops *ops,
> +					      size_t priv_size)
> +{
> +	struct devlink_shd *shd;
> +	struct devlink *devlink;
> +
> +	devlink = devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
> +				NULL);

Does devlink_alloc() set the correct dev_name for the shared instance?
Looking at the dev==NULL path in devlink_alloc_ns() (introduced in the
parent commit 80a67bcc7d4c), dev_name is set via:

net/devlink/core.c:devlink_alloc_ns() {
    ...
    if (!dev) {
        devlink->dev_name = kasprintf(GFP_KERNEL, "%u", devlink->index);
        ...
    }
    ...
    xa_alloc_cyclic(&devlinks, &devlink->index, devlink, ...)
}

The kasprintf() call happens before xa_alloc_cyclic() assigns the real
index. Since devlink was allocated with kvzalloc, devlink->index is 0 at
that point, so dev_name is always "0" regardless of the real assigned
index.

This means the shared devlink instance is registered and announced via
netlink with an incorrect identity (bus_name="devlink_index", dev_name="0"
instead of the actual index). The commit message example shows
'devlink_index/1: index 1', confirming the name should match the real
index.

> +	if (!devlink)
> +		return NULL;
> +	shd = devlink_priv(devlink);
> +
> +	shd->id = kstrdup(id, GFP_KERNEL);
> +	if (!shd->id)
> +		goto err_kstrdup_id;
> +	refcount_set(&shd->refcount, 1);
> +
> +	devl_lock(devlink);
> +	devl_register(devlink);
> +	devl_unlock(devlink);
> +
> +	list_add_tail(&shd->list, &shd_list);
> +
> +	return shd;
> +
> +err_kstrdup_id:

This isn't a bug, but error labels should be named after the target not
the source in new code. Jakub Kicinski requested this in the V7 review:

  https://lore.kernel.org/netdev/20260202194946.64555356@kernel.org/

  "error labels should be named after the target not the source in new
  code"

You acknowledged this ("Okay. Tried to be consistent with the rest of the
code. But as you wish.") but the current code still uses err_kstrdup_id
(source-based) instead of a target-based name like err_free_devlink.

> +	devlink_free(devlink);
> +	return NULL;
> +}
> +
> +static void devlink_shd_destroy(struct devlink_shd *shd)
> +{
> +	struct devlink *devlink = priv_to_devlink(shd);
> +
> +	list_del(&shd->list);
> +	devl_lock(devlink);
> +	devl_unregister(devlink);
> +	devl_unlock(devlink);
> +	kfree(shd->id);
> +	devlink_free(devlink);
> +}
> +
> +/**
> + * devlink_shd_get - Get or create a shared devlink instance
> + * @id: Identifier string (e.g., serial number) for the shared instance
> + * @ops: Devlink operations structure
> + * @priv_size: Size of private data structure
> + *
> + * Get an existing shared devlink instance identified by @id, or create
> + * a new one if it doesn't exist. The device is automatically added to
> + * the shared instance's device list. Return the devlink instance

The kernel-doc comment states "The device is automatically added to the
shared instance's device list" but the function does not add any device to
any device list. The function manages a shared devlink instance identified
by a string id with reference counting -- there is no device parameter and
no device list operation. Should this sentence be removed or corrected to
accurately describe the get-or-create-by-id semantics?

> + * with a reference held. The caller must call devlink_shd_put() when done.
> + *
> + * Return: Pointer to the shared devlink instance on success,
> + *         NULL on failure
> + */
> +struct devlink *devlink_shd_get(const char *id,
> +				const struct devlink_ops *ops,
> +				size_t priv_size)
> +{
> +	struct devlink_shd *shd;
> +
> +	if (WARN_ON(!id || !ops))

Jakub Kicinski suggested removing defensive NULL checks in the V7 review:

  https://lore.kernel.org/netdev/20260202194946.64555356@kernel.org/

  "Seems a little too defensive to check input attrs against NULL. Let the
  kernel crash if someone is foolish enough.."

You acknowledged this ("Okay.") but the current code still includes the
WARN_ON(!id || !ops) check.

> +		return NULL;
> +
> +	mutex_lock(&shd_mutex);
> +
> +	shd = devlink_shd_lookup(id);
> +	if (!shd)
> +		shd = devlink_shd_create(id, ops, priv_size);
> +	else
> +		refcount_inc(&shd->refcount);
> +
> +	mutex_unlock(&shd_mutex);
> +	return shd ? priv_to_devlink(shd) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(devlink_shd_get);
> +
> +/**
> + * devlink_shd_put - Release a reference on a shared devlink instance
> + * @devlink: Shared devlink instance
> + *
> + * Release a reference on a shared devlink instance obtained via
> + * devlink_shd_get().
> + */
> +void devlink_shd_put(struct devlink *devlink)
> +{
> +	struct devlink_shd *shd;
> +
> +	if (WARN_ON(!devlink))

Jakub Kicinski suggested removing this defensive check as well (referring
to his previous comment):

  https://lore.kernel.org/netdev/20260202194946.64555356@kernel.org/

  "ditto"

You acknowledged this ("Okay.") but the current code still includes the
WARN_ON(!devlink) check.

> +		return;
> +
> +	mutex_lock(&shd_mutex);
> +	shd = devlink_priv(devlink);
> +	if (refcount_dec_and_test(&shd->refcount))
> +		devlink_shd_destroy(shd);
> +	mutex_unlock(&shd_mutex);
> +}
> +EXPORT_SYMBOL_GPL(devlink_shd_put);

[ ... ]

