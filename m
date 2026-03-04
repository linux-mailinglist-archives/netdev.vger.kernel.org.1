Return-Path: <netdev+bounces-263497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLY/B9F5p2kshwAAu9opvQ
	(envelope-from <netdev+bounces-263497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:16:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E931F8C9A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E67703008CB5
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0C299A87;
	Wed,  4 Mar 2026 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4GzG+Jb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A228690;
	Wed,  4 Mar 2026 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583370; cv=none; b=kVLgyN2hRJKGU9kFWYqctWc5yNZ3UaQPpMv79uJcVo+0Ydce55tt24rui930tWP40Q1YmKSLfGc2Q1l1tjzO0fVvSEiiARgnWgshAQsEhYu+h7lABRqWSJjfJp/9PbwUKFqJiP6tRYHk2atAS+InRK449lpGp5quNw8W4KcWvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583370; c=relaxed/simple;
	bh=KSvzOs7RbuEecnAo32EKvW2/iKM0O+RI6xer47V1dXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPozalbNwaJqYShSosYnS9Fxq09Y2bPX5/ZqneuAw4DAc1r+g2/hS+YotfnO9XMzgf4mTovE3b4HbRDqbieBYBnq95sTiimTyC+JQVZ540dRMiyJ7QxxnoA51ZRfdLS9ox2WMxUpiZzspLT3BUjAgKJE+E7CPt70g2U4gUg0nRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4GzG+Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1EBC116C6;
	Wed,  4 Mar 2026 00:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772583369;
	bh=KSvzOs7RbuEecnAo32EKvW2/iKM0O+RI6xer47V1dXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R4GzG+Jb0cZQZx3us7w2pr8WE62vINBtVBh/tNLOEZjIMv2ZIWypUJZ41VMjPKZlg
	 b9kzS+H4XruNNXJrbDosplStV/PfaRwn7cngcun3FQFL8USJ9V78sVQc3MmaYaDlev
	 rnjBy9hy4xN+Si1nEa96pKkGcvyqQcV8a6kFZbj980qtmpEdIobzueL3ghvD19Oqex
	 rOrjrHDfCllBUAm4C/BTFvODfQKwvjWyI270rLWoJ3PcyTWyPPuKFMgNlB647Xi3AT
	 4It9WWJQb5xiTdLxLrmOGLKtpLJpqlZmvTpoxl/b2QBftFJNp3KAr0a6btQUrZaxN2
	 JXMlPLRVQK+Zw==
Date: Tue, 3 Mar 2026 16:16:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 5/5] selftests: rss_drv: Add RSS indirection
 table resize tests
Message-ID: <20260303161608.647d4c4b@kernel.org>
In-Reply-To: <20260303181535.2671734-6-bjorn@kernel.org>
References: <20260303181535.2671734-1-bjorn@kernel.org>
	<20260303181535.2671734-6-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 24E931F8C9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263497-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue,  3 Mar 2026 19:15:33 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> +def _require_dynamic_indir_size(cfg, ch_max):
> +    """Skip if the device does not dynamically size its indirection tabl=
e."""
> +    ethtool(f"-X {cfg.ifname} default")
> +    ethtool(f"-L {cfg.ifname} combined 2")
> +    small =3D len(_get_rss(cfg)['rss-indirection-table'])
> +    ethtool(f"-L {cfg.ifname} combined {ch_max}")
> +    large =3D len(_get_rss(cfg)['rss-indirection-table'])
> +
> +    if small =3D=3D large:
> +        raise KsftSkipEx("Device does not dynamically size indirection t=
able")
> +
> +
>  @ksft_variants([
>      KsftNamedVariant("main", False),
>      KsftNamedVariant("ctx", True),
> @@ -76,11 +88,90 @@ def indir_size_4x(cfg, create_context):
>          _test_rss_indir_size(cfg, test_max, context=3Dctx_id)
> =20
> =20
> +@ksft_variants([
> +    KsftNamedVariant("main", False),
> +    KsftNamedVariant("ctx", True),
> +])
> +def resize_periodic(cfg, create_context):
> +    """Test that a periodic indirection table survives channel changes.
> +
> +    Set a periodic table (equal 2), reduce channels to trigger a
> +    fold, then increase to trigger an unfold. Verify the table pattern
> +    is preserved and the size tracks the channel count.
> +    """
> +    channels =3D cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifi=
ndex}})
> +    ch_max =3D channels.get('combined-max', 0)
> +    qcnt =3D channels['combined-count']
> +
> +    if ch_max < 4:
> +        raise KsftSkipEx(f"Not enough queues for the test: max=3D{ch_max=
}")
> +
> +    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
> +    ethtool(f"-L {cfg.ifname} combined {ch_max}")
> +
> +    _require_dynamic_indir_size(cfg, ch_max)
> +
> +    ctx_id =3D _maybe_create_context(cfg, create_context)
> +    ctx_ref =3D f"context {ctx_id}" if ctx_id else ""
> +
> +    ethtool(f"-X {cfg.ifname} {ctx_ref} equal 2")
> +    if not create_context:
> +        defer(ethtool, f"-X {cfg.ifname} default")
> +
> +    orig_size =3D len(_get_rss(cfg, context=3Dctx_id)['rss-indirection-t=
able'])
> +
> +    # Shrink =E2=80=94 should fold
> +    ethtool(f"-L {cfg.ifname} combined 2")

I wonder if we may miss some cases because we init the table to [0, 1]
and also only enable only 2 queues. Let's set it to 4 queues here to
potentially catch the driver resetting the table? 2 vs 4 are both tiny
values.

Alternatively we could use netlink to set the inidir table as
 [1, 0] x N
rather than
 [0, 1] x N

and..

> +    rss =3D _get_rss(cfg, context=3Dctx_id)
> +    indir =3D rss['rss-indirection-table']
> +
> +    ksft_ge(orig_size, len(indir), "Table did not shrink")
> +    ksft_eq(set(indir), {0, 1}, "Folded table has wrong queues")

here actually check

	ksft_eq(indir, [1, 0] * (len / 2), "Folded table has wrong queues")

> +    # Grow back =E2=80=94 should unfold
> +    ethtool(f"-L {cfg.ifname} combined {ch_max}")
> +    rss =3D _get_rss(cfg, context=3Dctx_id)
> +    indir =3D rss['rss-indirection-table']
> +
> +    ksft_eq(len(indir), orig_size, "Table size not restored")
> +    ksft_eq(set(indir), {0, 1}, "Unfolded table has wrong queues")
> +
> +
> +def resize_nonperiodic_reject(cfg):
> +    """Test that a non-periodic table blocks channel reduction.
> +
> +    Set equal weight across all queues so the table is not periodic
> +    at any smaller size, then verify channel reduction is rejected.
> +    """
> +    channels =3D cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifi=
ndex}})
> +    ch_max =3D channels.get('combined-max', 0)
> +    qcnt =3D channels['combined-count']
> +
> +    if ch_max < 4:
> +        raise KsftSkipEx(f"Not enough queues for the test: max=3D{ch_max=
}")
> +
> +    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
> +    ethtool(f"-L {cfg.ifname} combined {ch_max}")
> +
> +    _require_dynamic_indir_size(cfg, ch_max)
> +
> +    ethtool(f"-X {cfg.ifname} equal {ch_max}")
> +    defer(ethtool, f"-X {cfg.ifname} default")
> +
> +    try:
> +        ethtool(f"-L {cfg.ifname} combined 2")
> +    except CmdExitFailure:
> +        pass
> +    else:
> +        raise KsftFailEx("Channel reduction should fail with non-periodi=
c table")

grep for ksft_raises()

>  def main() -> None:
>      """ Ksft boiler plate main """
> -    with NetDrvEnv(__file__) as cfg:
> +    with NetDrvEnv(__file__, queue_count=3D8) as cfg:

the queue_count=3D8 presumably only applies to netdevsim so it should go

>          cfg.ethnl =3D EthtoolFamily()
> -        ksft_run([indir_size_4x], args=3D(cfg, ))
> +        ksft_run([indir_size_4x, resize_periodic,
> +                  resize_nonperiodic_reject], args=3D(cfg, ))
>      ksft_exit()
> =20
> =20


