Return-Path: <netdev+bounces-279083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EiKC/8B4WmJoQAAu9opvQ
	(envelope-from <netdev+bounces-279083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:36:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 948CC410F97
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA6DF3085AB9
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954073E2747;
	Thu, 16 Apr 2026 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="azrHcD7Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD73E2770
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353525; cv=pass; b=Rli/EYrQx1vtyLggCXigylV4rUqYKik4WRiTbzQtwPMRZv5naxbHCCd/Fzp651BcQCTAcCGov65FlqgAdgqrvGQ8cCBay9LNVKE3quGSycrWVIx2P4/lA1c+cYZOtKEcwrYWnidYfWWTVIJ42YTm1jFjsBx0fdTSUWUFjY0hpcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353525; c=relaxed/simple;
	bh=C9qNgXKpPG8fx/LrMxZ0XBzZwjFqxdU+6QWzvkwaCqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHbErp37GHBhsGCTzgavT9P9ZU6VFGb0C8AKpHJrshHnGGyQrZv/Lh17O0NIGQFI2RbQJ8pfKplwjsfXR6MLMnFV3652y5fAv9hneN0YXuqu2kTVSV4ne5Ih5/OfJlqhRISbwd88P9fF9FJbz6T0QhmQANUcxtGQgTqEBeNs1Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=azrHcD7Y; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82d0b68837aso4480555b3a.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776353523; cv=none;
        d=google.com; s=arc-20240605;
        b=VcoNlblKJcqfcPk1abvQEoDWxDvNS7HvcC/ZnwSdMC6ycDX5VnuMAxwwbVtAVu6yOs
         9SqVvpkSxTbtefiIYd4QanQWGI8aIUMO4KSDjPvWDNeQwgxMI+Y5h15dvOJKKJ9bezDg
         asYcIBRvBWoATWPrNCMldkPQRhgRfnl6b9brSfryFCl+bc9BgcDc5Wl8bm4biC35n8KH
         mSFMLg94rRO53A10fiaSzBWcsBPzLQaFs7RAyqKB7TDZK+w7GY4cjMZCUg/YJtihtrdw
         DhRvBRXPOWuLrGSn3QzMqbc1TLa3i3XAsaZUiWDR4EVY8Wm+RK/FW/MfyQHpkXK1mlXP
         ayrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3PsJyAQVoXbmJLDOdWDxzv2P+fg70kP2W5z3IRIUDlM=;
        fh=Lh4IwkOtF1O/zeasB6BtlE0omKpoEp2fjg/gFgLgnM8=;
        b=NVsxtQeo4LI/Pe5sp/Jmffn/j40PKtJuaFDmNCw/NKSwS//X7H63WFfPXJlVZDNuH+
         +hvgQwIR2IGviL2wo5ZJiTUpwLLOQOxhY3K5XErDVK0vVyM6sehdtd+hwn9akwmWexwR
         EXWnCabB18LxmjTgoWaTHIfR4dyzNB9t6QaLOy/r0ywUzT1z2niQI5UFHd17hpJE574n
         NUY/zDEP3KuPpXq8vsIGcxwCVfGaMJbw5IhEYu0kfgdfwOZg5GPD6sYNsugEcmaTrLVW
         icw8G72virFXA3XCWG4SKRkL52whG6raZqEyo8OeQHf+akPQenJXs7nJpgOm4bRpXsnB
         tYSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1776353523; x=1776958323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PsJyAQVoXbmJLDOdWDxzv2P+fg70kP2W5z3IRIUDlM=;
        b=azrHcD7YFxO1SSAIpsdeR4t0HTXydUT3CUX8t3VhkQmkaAxXRUjz27FjpMhEQJsCps
         VbMoQm7THZx3po0gB9Tg12LGEZCfVqRW8n8r0vQ5Ocsh+nbUGMRfjf5m8ji8S5bbkpUC
         CCOPUBfpS9NydCBl/62NkW8zw2GpkMO3MUDZKtVV4gMCapdPx3xZ8RYEAgCVyvYqEnNY
         pui6iXTM0cvzHQ+C9MDLZzFyNIjIYZpcfHSkdL7ZpcZRE47SpyZTaLj4+nyPSxrfxi76
         HpbkCH1QIWmQyfkQT2wGDqSX7edIgDH7TL7TVeEMdTkQtbXJMI9GtdXwCpgF7FBmr2SF
         Y5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353523; x=1776958323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PsJyAQVoXbmJLDOdWDxzv2P+fg70kP2W5z3IRIUDlM=;
        b=e2EbuMdBoCtYYT9o6+9z1YcMHaeMEfZeYyu3wk1tn7IdBwxewKuzMc3Tz7CRSFTLbe
         2WUIV7dupixQYq4PR8YAhssRXgvcQfvV8TCgMYowFQLLZntSCjrYowlsbu/ZCtUPpk02
         twf0XZNh8esEi9g3xvU4pidYbW8xebmXdT/X2ZocDZaxHRnfWVyZsp5nSIu0pbYMEoF+
         Vkhiwf2eg/0WvDoPZ7/FWEDD9qkoVghEAt4S68/UhZaGKI8fy7a5k+C7T344iwFpCSuI
         83jbsTSY6V3saL4Eczf4141e13z07Xwcd9kGhjKAE/oE35q0cyZ8Ph0X8goEW9Nh6kZg
         Y51Q==
X-Gm-Message-State: AOJu0YxtNAt7OAaGwjxoZecLB50bNm4ymmkrtKvc7/Q2pxOnVCZiH3WV
	8Q8V0IqUs7x+96Z6kGrt3amSCYBKI8S/XlHM9dL7zTk/FyvxciiD+dG38adZxApV4Ey9zc56M1R
	jZ6fRWG0OglnJOIbRWx0EHkVMlwi/X58k4ALBdSrkuiYEvku49vg=
X-Gm-Gg: AeBDiesyT4wDjJPqHuozIYMA3zB4ViTT5vlWqGleqfdWGVrMYR+O1V0tgI4q8gWeB6X
	VSGLS0DrJIDW+jZmx46v4qFVVYmmjhypo45cqX9KMygAY4+pRqbBKH9t8vDrNJ+I83MlaJ/Vr3M
	m0ovPBqL5cgJrCmhonoo3WnMMWq0eLKq3KV5jXbilJmFfgZb1DI/IQP8uL49VltO2bVWwFa2hNM
	eSTmDdcMsaPSChyzGBC5Ub0BJRdw3sw7+Idet+K3lNv94o9tUzrAqI2HJtTiNS9knN2/YYhdOWY
	7VJHB42yHmuaK+/RXv4=
X-Received: by 2002:a05:6a00:a884:b0:82f:4d2e:5a9a with SMTP id
 d2e1a72fcca58-82f4d2e5d21mr13228253b3a.29.1776353523513; Thu, 16 Apr 2026
 08:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416130138.38050-1-phx0fer@gmail.com>
In-Reply-To: <20260416130138.38050-1-phx0fer@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 16 Apr 2026 11:31:52 -0400
X-Gm-Features: AQROBzD692NX7sX0-fLEZFNE-CF7EB4l4K77jL1MpBBfqIDZ1oT6-_D58WClVtA
Message-ID: <CAM0EoMmi0tdhB9ECmcpPea7iSFm5AiLme71cw5zXK+WVUZGEMw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_ct: fix skb leak on fragment check failure
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-279083-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 948CC410F97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 9:01=E2=80=AFAM Dudu Lu <phx0fer@gmail.com> wrote:
>
> When tcf_ct_handle_fragments() returns an error other than -EINPROGRESS
> (e.g. -EINVAL from malformed fragments), tcf_ct_act() jumps to out_frag
> which unconditionally returns TC_ACT_CONSUMED. This tells the caller the
> skb was consumed, but it was not freed, leaking one skb per malformed
> fragment.
>
> TC_ACT_CONSUMED is only correct for -EINPROGRESS, where defragmentation
> is genuinely in progress and the skb has been queued. For all other
> errors the skb is still owned by the caller and must be freed via
> TC_ACT_SHOT.
>
> Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo fr=
ags")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>

Do you have a reproducer? Always helps adding at least a tdc test.
Also: How did you find this issue? was it AI? If yes, please add the
tag "Assisted-by:<AI name here>"

cheers,
jamal

> ---
>  net/sched/act_ct.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 7d5e50c921a0..870655f682bd 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1107,8 +1107,10 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *s=
kb, const struct tc_action *a,
>         return retval;
>
>  out_frag:
> -       if (err !=3D -EINPROGRESS)
> +       if (err !=3D -EINPROGRESS) {
>                 tcf_action_inc_drop_qstats(&c->common);
> +               return TC_ACT_SHOT;
> +       }
>         return TC_ACT_CONSUMED;
>
>  drop:
> --
> 2.39.3 (Apple Git-145)
>

