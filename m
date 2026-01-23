Return-Path: <netdev+bounces-252723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJCHEUM9c2kztgAAu9opvQ
	(envelope-from <netdev+bounces-252723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:20:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A37324A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ACF930173B2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A822B33A9CF;
	Fri, 23 Jan 2026 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qh0saJE7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486C321F54
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159951; cv=pass; b=u3+I9DQDFyfplttqRVRM23LwOxlV2mLurDM+EwbnTxFzcnjqCp960Bakjtc2Dk6W6DHWHyAHoLXeerW6C06cxZeDd9EY0nfJ+ar43wmxNCZACUDwYGVEWKpn0I8dqjqOyd+ZCA72TmN/5Omkfza1hRaa/74TZszryqJBgb6WVbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159951; c=relaxed/simple;
	bh=9rdQ8Ar1WfFW+AbcxSH/QMsiVMTd7gkhk6wPglHFFwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vvtcof1JyXMv/kW8228Uyn1E1hhPIlgXO7QeLcGs9o5WviD805WH06nkqcSGvHupfP4mCdLmsfajtxc19/ruVgTrtOWaFePjDUON+3pNwiNnsVn90Mm/fCUdWX7/20AhU6wP4SHPXqG6GMl1lO+w3f4AeteJnMkII9EvGB8Oph4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qh0saJE7; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-502b698e510so28339921cf.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:19:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769159947; cv=none;
        d=google.com; s=arc-20240605;
        b=Awl9yLk1V8XsuQcU24q8QYhsG6jZl6HhCUAmZBgPBtGetYfHkMD2TtZxOBkVeFC9AN
         NrO4tcbwfEt9iZmiNDaYCCLkIT6dMECKE0/FLDRo1RsadxjvIrTsYvGCsoesGIhBzSU8
         qhNvnSwHurnZVqMDcTgJdnw3uhhHQDsLwZ6hr6IaPYzkky6Q3B5rIJXwTgq7wV9m6Qa0
         36xY96MEprojHmx30RZ7ghjEIlHF0gAJLbQuQ7Ocl5O2jfqYkUtTdY1ylChONApEuCbl
         GDShwxPaik+vR0Y9Zg8bdXOMELxzW2FMFRXN+RiyLVr+TAoD8k+nggjHQRGcgpnxA7tg
         sQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ll2l1W0Dq54Ly/gy7Y0JOY6nNe9Fdyokd9PNcCBGNU=;
        fh=W3I/D7ZO6/W+NOFIUQtkfrUwm83xfXk8duhpv1o7H/g=;
        b=bta0ZVry6jmO3Dxf8wWF+AmoRS3j86qa1ImGUUo+f0N1QOmFoRWMwDfsNyeCSePofp
         l+eBuqHbJyO7yq7keu7YIz24oaA/JAIl/S6gIli8vlHK4oDzdYtzizSI2Jb3lroJAPCW
         aLdCwiYkliZ2m7BzuM49t9Fd37dzHoSV3dJAW3YBNJ+XQ/qsekWEcQ9USdnFF3srt580
         ZZzXaRXeNmSzIflaN8nErzmMbpGPrUsEfA3qcepKfy6Xj4xqMAQx4XlVl/EiHiikAkbE
         pDzMcX7KbkgQWWztA6XgL9+cjflIJvozCrb9TdiKNQpBIBgEq/S2ERE2KcRjh9I+XoMj
         LxtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769159947; x=1769764747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ll2l1W0Dq54Ly/gy7Y0JOY6nNe9Fdyokd9PNcCBGNU=;
        b=Qh0saJE7T4G4hi9e0WPYsxApdriqS9QLU/+c3M/Me57eUneZkbB9KL8T6NzHs5MPC+
         l2MsxXXOxYLzJP67qP/WtwYgoQeRbAjGNraNJR2JhG+SSccvWWMO84++HOFAJmoY4coW
         Ehr005eshF3gAOhlyExqW3KB1sbUVe7Vx7HdYtLwsCLg/q7AKPQJcILXOzxUVFTHKJSH
         lLOFa80YaX1DJ1BkKRlakAi8lmGTDumpfIJDjGoLLWu4bPQ6SculNjqrEMGgD0kArOCS
         q7JBO2j3MWPq00AW1zef8DXsE5fLLsbT6gXIFaZ47tJ5OOIM7Vm2/20F5zfP/kgKKr+H
         arVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769159947; x=1769764747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ll2l1W0Dq54Ly/gy7Y0JOY6nNe9Fdyokd9PNcCBGNU=;
        b=bj1cVBfim63CyALxp4NbZuanlMNxB1Xjl+hg6WCjhwNjBhqVVsLFt2cn4QHMXc0w+V
         Sros36pHeF5QCujo9WJCXMlzV9yeac3tYWu++FvtoyR/JU48IX0i1v6ClpimNVyoFlNq
         bRAnqpUac8NwD6aoVvEjLtQoWQ4a2+u6Zm4Ql4P66q+WbMklmtXCBqreoJxzE6zjIMQ1
         J0BsH25ltzGaFmYWMHXNxWklJsV/yxWIl+QdCxrw4BMP6wtFbV2GU1UC5da2ax6Cbzhl
         s4TKdlLYDb+OpAFJDMuIb/4HcZNrHbIacBM8AdDcQ/B2RjzkaHmtdt+vVGYeo1rU1VMb
         TcGw==
X-Forwarded-Encrypted: i=1; AJvYcCWo1jgoF+zu9xYEqn+q8XttOD326OzFnelYLscErNX6AnnflFR3lpt8f3AhVee9sM1xVE40cvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAr88y9KNu7RYb/PWZF4jgkcbusIjvIVqi+9mW3CLxYRoo9oQD
	Ha2B7SDrLsvKuDtY9QLm5GceRdLLyD417Q2pcvKyKFjlVivFEfzV3+bfZRqIPPPhqah1KEHEBtI
	ARCRQgjINCOlIORW8t9BL4VR1t7PH8fR8mtrDasKs
X-Gm-Gg: AZuq6aK6LGHDvic2P9Vzl9FMx0TReuHgoTj+WD5BgEBM0Df7P+2f4d8/8IczlszqO8Y
	a/QEXCuEqhGIIZiUr/CUy66e05vvndOBrHg8eCKapFsLUGUjScTITzez+NW7NaKOnG8CfkHl+L3
	HZXV27d65ePlOw5vUhSHu6rmZSxz3ejQJZzhHSPNqYa5KsNxd8Bo95u3uJJmw2CfPhFwk2AiPPN
	tNuO4+bJsasUVr3zF6XrC0cUivVS4XkbTlJHIIdcYLI2VJiNKdI6s5Tb3bfnfVV3Mo6zVOYvwg/
	CrLTsw==
X-Received: by 2002:ac8:5d8d:0:b0:502:f0fd:1837 with SMTP id
 d75a77b69052e-502f77e0bc6mr30471261cf.70.1769159946500; Fri, 23 Jan 2026
 01:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123052721.3765743-1-boolli@google.com>
In-Reply-To: <20260123052721.3765743-1-boolli@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Jan 2026 10:18:55 +0100
X-Gm-Features: AZwV_Qh3LeuuTXmx8TW6rSxS-Y-qUSUhuZt-TYjjrG1zsLFg_2AJooEHXo_RgzY
Message-ID: <CANn89i+ocUUpwzf-0t6_H9eZo3cikwrKd4ymtDkRL8W7g7uz0A@mail.gmail.com>
Subject: Re: [PATCH] idpf: nullify pointers after they are freed
To: Li Li <boolli@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Decotigny <decot@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Brian Vazquez <brianvv@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252723-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C0A37324A
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 6:27=E2=80=AFAM Li Li <boolli@google.com> wrote:
>
> rss_data->rss_key and vport->q_vector_idxs need to be nullified after
> they are freed. Checks like "if (!rss_data->rss_key)" and
> "if (!vport->q_vector_idxs)" in the code could fail if they are not
> nullified.
>
> Tested: built and booted the kernel.
>
> Fixes: 83f38f210b85 ("idpf: Fix RSS LUT NULL pointer crash on early ethto=
ol operations")
> Fixes: 8a558cbda51b ("idpf: fix potential memory leak on kcalloc() failur=
e")
> Signed-off-by: Li Li <boolli@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index 131a8121839bd..7af4214ec44de 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1308,8 +1308,10 @@ static struct idpf_vport *idpf_vport_alloc(struct =
idpf_adapter *adapter,
>
>  free_rss_key:
>         kfree(rss_data->rss_key);
> +       rss_data->rss_key =3D NULL;
>  free_vector_idxs:
>         kfree(vport->q_vector_idxs);
> +       vport->q_vector_idxs =3D NULL;

vport is freed right after this line.

vport->q_vector_idxs content is not relevant.

If anything tries to deref vport->any_field ater at this point, there
is another bug. KASAN might help.

>  free_vport:
>         kfree(vport);
>
> --
> 2.52.0.457.g6b5491de43-goog
>

