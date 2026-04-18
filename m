Return-Path: <netdev+bounces-279502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJEQChuE42nCHwEAu9opvQ
	(envelope-from <netdev+bounces-279502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:16:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E204212A2
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C195D3022FBB
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA8619CCF7;
	Sat, 18 Apr 2026 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVPz5+hX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1A757EA
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518163; cv=pass; b=gxUtzfL3nr+NLvpu00nyZUX1ev0D4h9xMAGCj6+odtl05LHChqz1FD45XCrsOLA8U3ujPcYPYIeJCcHEgllTy/AhD8gLRT66R03okv9OUiUUMqfIRv4KPLOr6f4u9XJdGss86+/ROQUaxe5GSFo9V0vntu/GWEy78Zy+94xSqII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518163; c=relaxed/simple;
	bh=/dJIL/ctnSO0VlgUQRJRqfMyxKhwbC2esVeZUsQuZ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6VX8ydXVTw/TQvA6hDhZ3ISruJacnxVBLvY1gi7B1DfsSrEu6ARN3TzyubK6CvLTSE73T+4HfyxCOqQEnnaJUxyfEIuT6Kjrn5UDVENXDOfnwFg0TKpCTpcvWgSTyGHLQIwQo53LVcu/L8moj+vNODKJtkMwuTvetTJvrUt/ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVPz5+hX; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50baafd6c4aso18909561cf.1
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 06:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776518161; cv=none;
        d=google.com; s=arc-20240605;
        b=BxDoQ3TEKsypeyY82LIjkb3Oc70/RyVEKCNsUzs6q0uQbYkopJE3ZWBOrfX2JL3kf6
         KQs4z7XpQUgmr+34XKgRiy/cDv9Ok6R3r6YTR8WWxYijiIRsdVekt0I4pAb7Tz+ryy7A
         57La9frYumZkxoDzX8m+SCwL0gu3qqzDFSp62ipuOfyAZzDktiCeBrt7QXkjP4dxoZvA
         U79biKTZFu8WUpypt55/rM7dMr6f8y2aOAiUauv0HsX5OTxS147aZngWEdOJAMsbEiQs
         f54NR36iO7y7Q0IRoJhCowqVv5RChppVlcPsdA5aZYzZUa3HOBa/Q+eP67SI5OwtFK4D
         Zj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xkJzaS3R6Ulj/UYjZfMjGp0BJedB1UduVD4qVxf4rRw=;
        fh=kYqk3Sd8l7P/+ou6y53wQzJqvtjX4lWNdYyJp8Hs4nQ=;
        b=iiL1eayFw044EWD09llCEEkXiy1JoQwtf3XdtOvAKbHv9gPrnXiiiMs6g/ebOjN0HH
         SnBYNU20lH5Ao1aVUTU/b/35jzyPu+P4HHOcjSI7Mp+pik7v2DZa0zR4BtYqAPYP2IUR
         ypH5G7rEa7g5CTljAkltvKSa3pV1DoNnezn8UPO6bzNvdDAb7UBpZAQHTfPUSMgex0F/
         in5EmNOnxrTvmfe7s2QKHtUdGARrWTuSGHELnnp9wkQjK/7deOIhFBwuF/vU9CNsxYqJ
         ghugKvvP0J7LFrJiKu0h6dej9/Dm6y8pxw8iOafaA9uyIV1digvOQtLehzNzn8R3zfoX
         qLQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776518161; x=1777122961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkJzaS3R6Ulj/UYjZfMjGp0BJedB1UduVD4qVxf4rRw=;
        b=hVPz5+hXgl+zYlxBKKoAMgp2U8TBRcjdB2nhJ/N9lDbczCiFVrKKrPUJCplDSn8nvb
         gHVssR1rEtBvLs+dKrqu1EYG5wRdUqCoQT2Enm0D9pP/QwAMfVcCPnXCs/uh+oYxs1TD
         idhCa5J3idB7X19Qc0UqA27pXbBBahGBSfD6KEeTLPE6waDmpIF779RHd8L47Du1GbqI
         K7EDBlk62Js3lNIvTgqp5UdUEJlX3A5AgVuoqO5rqVn72rJeIpnO6oSiMt1RKIgH+38/
         jWNemF1q6gbR7XGJ+37I++YxZ//FGHIM3R5IhnLwUwFCZ3PjVeSA4tKmP1WVMBHfAOgp
         cKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776518161; x=1777122961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkJzaS3R6Ulj/UYjZfMjGp0BJedB1UduVD4qVxf4rRw=;
        b=qRNG8m0U2ZUkfwsJ1tDzZ2FBw1SXiRCzCqj1+/T/1YHYm43Nu5puTi/yzFUw0s4j+L
         JvkseDrucVt4xbWDWJLEMLQ5yJ70CYViifi/NF0LhY83ugvS2gm4fnLn4UwuiZUhysWR
         h7wpX9KVSDDYhDSR+MVCq63Jj6x/244YvbWGDa5wP3eT5j2ry0bkt9uM4OF0/yK4Zsdh
         9vcRGrFlmEgT3SfOwXSDleAwgkX1p7/utOKB/wKPsU4Pr5oNz9CZy0FMaB01OkT6I1D9
         6eAu/2om+PCH5IFp917Eg+w3PZ4o7JYvAIayIRwM0LOjrxL3sp6Nh+tOw+etbGE/rzMu
         VJ2g==
X-Forwarded-Encrypted: i=1; AFNElJ8eH8SA27bUcAjMSUA7Cz018lfyL8kRXVeuB2sMM2lehVBOhtsip4xK7Q0UtDMOSpX9ifLb3xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/L8SgVJ+S84rUaDzbzcEqUsMnYgPcx8MGejbKp4/nAloZ0na
	XBHSAWl7m8rl1zhy2zFZil8vnyy3sfyxe9Wf6YthuTJsAZVktEdA+kpJyuw8+CaO4pBLX1lJ0gf
	wxDqT4Pr1PGT4rOH5I9Ihl5mZ74wk/CgEJH3QWAms
X-Gm-Gg: AeBDievVu9XIpTN7tzZ+/vb99V8Mgha/Z3p2LWCd+C6yb1QDAJ7CYbfQiyt/3h2bo2M
	2zZ4Ey58BBb3VXaHiaE29LxZPFhOT1ULKNXxObInwFTzLq2c4ZjYW9C7ZsVWSgSpNABQ9NIy/eV
	t+YHEN4ujZeVaJHK0XqDcncNGlRRAFHj0lvUpaEPOxGJiWX5KlXqGQbIcJ+IlOUpjhVggigmtlJ
	ZbqpZXaKeSUtGMauv+FrocfYa17cdKdJb0nW/RZfWC7mYzTeGLt87YP4xQBeTNix/I05W3zGEX3
	QzTuHIdTMjR0FKv/YrnECiZkzMs9hifcEWQ7ner1hE1XXIRgVP4V0lUagGe5uScWNtRWijmJL+d
	lCtOg8Tc=
X-Received: by 2002:a05:622a:4d4c:b0:50b:4a84:aa8b with SMTP id
 d75a77b69052e-50e36b87666mr99734631cf.12.1776518160228; Sat, 18 Apr 2026
 06:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417171831.687053-1-daniel@iogearbox.net> <60b47924-dae4-4a10-b977-75b92e1094c0@gmail.com>
 <ae053593-907e-4891-90fb-03b4c5d8f5e1@iogearbox.net> <b57f31a2-456e-4727-839a-bc2f0fb07855@gmail.com>
In-Reply-To: <b57f31a2-456e-4727-839a-bc2f0fb07855@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 18 Apr 2026 06:15:48 -0700
X-Gm-Features: AQROBzDsBc8oSUpAaTLPC2I1syKg4k_WM1htttj4FllMXCkjaHk8SifZPQ-hDN4
Message-ID: <CANn89i+Y0jctj8=tCHFP5jDSJBAWR=RvNfagammc-WqU6EdPRw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: Implement limits on extension header parsing
To: Justin Iurman <justin.iurman@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org, dsahern@kernel.org, 
	tom@herbertland.com, willemdebruijn.kernel@gmail.com, idosch@nvidia.com, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279502-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A1E204212A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 5:50=E2=80=AFAM Justin Iurman <justin.iurman@gmail.=
com> wrote:
>
> On 4/18/26 14:26, Daniel Borkmann wrote:
> > Hi Justin,
> >
> > On 4/18/26 1:45 PM, Justin Iurman wrote:
> >> On 4/17/26 19:18, Daniel Borkmann wrote:
> > [...]
> >>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> >>> index d2cd33e2698d..93f865545a7c 100644
> >>> --- a/net/ipv6/sysctl_net_ipv6.c
> >>> +++ b/net/ipv6/sysctl_net_ipv6.c
> >>> @@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] =
=3D {
> >>>           .extra1        =3D SYSCTL_ZERO,
> >>>           .extra2        =3D &flowlabel_reflect_max,
> >>>       },
> >>> +    {
> >>> +        .procname    =3D "max_ext_hdrs_number",
> >>> +        .data        =3D &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
> >>> +        .maxlen        =3D sizeof(int),
> >>> +        .mode        =3D 0644,
> >>> +        .proc_handler    =3D proc_dointvec_minmax,
> >>> +        .extra1        =3D SYSCTL_ONE,
> >>> +    },
> >>>       {
> >>>           .procname    =3D "max_dst_opts_number",
> >>>           .data        =3D &init_net.ipv6.sysctl.max_dst_opts_cnt,
> >>
> >> NACKed-by: Justin Iurman <justin.iurman@gmail.com>
> >>
> >> +1000 on the need, but NAK on the way it is done. IMO, we don't want
> >> yet-another-sysctl for that. Instead, we have (well, not yet, but it's
> >> about time) this series [1] to enforce ordering and occurrences of
> >> Extension Headers, which is based on an IETF draft [2] (FYI, draft-
> >> ietf-6man-eh-limits is dead). I think we should enforce ordering and
> >> occurrences in this code path too, instead of relying on a sysctl.
> >> Let's keep both code paths consistent.
>
> Hi Daniel,
>
> > Hm, that series [1] should probably go to net instead of net-next, but =
atm
>
> +1, would make sense.
>
> > hasn't moved since a month. I'd still think max_ext_hdrs_number would b=
e
> > useful given it has less complexity also for stable, but I guess ultima=
tely
> > up to maintainers..
>
> In the short term, I agree. What worries me is that we end up with a
> redundant, or even useless, sysctl once the other series is applied,
> which will only increase user confusion.

Given the amount of bugs in this code, a sysctl is safe and quire reasonabl=
e.

No one will object when it is eventually removed (or has no action)

For the record,  I approve Daniel patch.

