Return-Path: <netdev+bounces-260753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB/8DSB1nmnCVQQAu9opvQ
	(envelope-from <netdev+bounces-260753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:05:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E451B191756
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2098306AF61
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A675529E113;
	Wed, 25 Feb 2026 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCJmSIWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E636D25A64C
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992344; cv=pass; b=OBAiKy5lYg2b1jOuXkTGH8HeFdj6wG+/sEbzWeYKsKcU+025i4AbIdwGaryIR6Top6swqfH8wUdpXIh4ydDrDw7zoaJwZ9b3hbDWZi901yXrdAtjdJWyAm90WDD+cfM7EH/f44U6XyBvSQIT83JqeEy0y6wWO+JCiWwK2Pamg8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992344; c=relaxed/simple;
	bh=O29QH1nqEi06EwceJfS+6Rm8Yz3WXybENc7Pz9CHxE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0Zhm/AL+fjpF8KjDEUyItFw6M9IAz+CEd7gL7MxSsxo8aDHpZdVNwzFT/7fhmYweR4ZqBGwfFH/yrjwwsSvsMXas6YDjkZOubVKS2f2v75FHupsrlwpWiXUDfR//Tb87JWkkzSjlFwfbC8K9Dkcq1lj/9f3sXxKw9Kuc07Ejdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCJmSIWe; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436317c80f7so270997f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 20:05:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771992340; cv=none;
        d=google.com; s=arc-20240605;
        b=bYNzvxXqd52noYJhPX/5N+bn+Rb4BL1Nj5KlDNdic3+m+tb+FBnNzewCWsIHk7S8Og
         QtxuK/O2aOOpPZKtxxSRuDF+og390R0B2hYpt1ag2aIzN2QNTmf1bPMfguMcx9feRnbp
         /3Oypmhnkj8748t7SyrSwkkQyIAuYxEw0VeNv4EDwhgcHlv4AFfnjdOxMoOB+MuTjNhB
         hvH3qKnn+ctAn4D7uQFzU8QYiZkYFQumeLGqlUn7lEhK/16P1ixXNXPKOPGb+Vtky+gr
         4jfa7Sw0guRq1UqSQqYStwGPw269EOsY5GXAx0lY2chgss92y4kdH4ADm3swrYNvayhC
         o1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vVj+eO1lEYzx1IPTvNrukfWxr4EtHXMYmANg24lti9I=;
        fh=PE26h8Bm5hXUFY9nrlnBb9by8LU+c4IU+SKX267IeH0=;
        b=QbRaQLc60jcvDHlSgxHB6gkcxHV6CNPuAGS7venVmfsGfdbFkRhSvHNYFyEqK1jcGJ
         FRyQ43vY+m7+Rhr1XcSQXj6pkC0//kzVDDD5B3e9Hbp/SaOc2IWODZCe596EHOdfe5O1
         /mmMM23b1uFjSoyNBm8dOza+8yzRTVDx3Q55UWegIoSGJZpuSrhulAV4XElBQSu+YG1H
         L45E4RwDITIaANcPEL39RcWy+5/Wqxcz5QY70EmRib3D+18tPxr1DJv3QtTMyroEbczs
         1AgQZH/nxbXd8WChJAgJsNnCns4+5Utf7Q7UwGF+AtLjQOWg8ybN8gV6PxJmc6hZP2RZ
         hx2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771992340; x=1772597140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVj+eO1lEYzx1IPTvNrukfWxr4EtHXMYmANg24lti9I=;
        b=KCJmSIWe7WCpKKdqLko5ApgRwIaaWMpUVehXaYYOorsjdpUkoBXdRemWnu7R1Ioejc
         B4Sh2rQlOG5fsfg7bmZm/TXSUYYJMhwokV4HwUZWNshuUJADhRYB0orU2FA/OubgRqcP
         vPCQJRHnS1howdqxz8FFpY/731h2iajO3zxA8fSBiHDdJqRQXceGDM2ep/h4b8JCxHA0
         avj1keuN6Lp3iCYjiN+v31Fkw2Uj729vQbPE2ldejANVyTcWA+bsai+6ixvzjQ2+HdEC
         Ce5Hs+1jE+/zWgPQu62KGBmHlBxLrBb07aIaXviIQXgQAeI8voAbeMf0LvNqKrlg9Gl8
         HXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771992340; x=1772597140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVj+eO1lEYzx1IPTvNrukfWxr4EtHXMYmANg24lti9I=;
        b=jPwFKcs5x8mYiK3FjyXOkUkTOZMJFkYCrrYhlGu/aUMdOhJ1wLmPZHbeIyn/MbpjcN
         vtJ+IDrdVhY9s3Q1/tblb8wHquHa7ZgcFWqtSj/Wt2zORbIz5fxWKSaX6MXxMr+q3nbI
         FUJXhKjBk2DSuegzuIMCe2uOlWM2iG5EVZEmXh02GxD3w/oiz31pUjAklycMgmVKIFb9
         yoVWIbsbp/5xTBupfr6QQLZuyVRDHvXTigVWOPf7oE+KiSn7eyS50LUI9rpH5t/hODzA
         07tz0Pe3b3bDWiMerUJTOoq0XLMI/XkbDj4NTfsxMa7WTjr3yKeCUziiGOwQiDZUs3Vd
         QSTA==
X-Forwarded-Encrypted: i=1; AJvYcCX2WAEKbb4MQlYTaSe6B4YLji3Z88QAI6Eye/uuL4AsxEGVzDanGkS4YltsclvRaLoWeW8QuJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8P6XCoB+u+7TDMozfyyGfyeOPh6rSqYa66P/6XLstYS1nBayj
	HTOVR3ZX+u5OSeUebvIjSg5cqBGEcqQi6XNW+ocJ+Bw/BCcNSjCsbMolZiHkcNJmzPA8+WfQAqC
	SqFEf4CVndg82kxVU1sn07fmGJ72mfRQ=
X-Gm-Gg: ATEYQzx/lf7E0fSXIJD5IOefYgmeu7byMjPY35gjJvV5LaZifdr1wXV2mx2k4AMJ+zB
	DNsrVLe4mkAHazXYeVy89x5BdU8tJmetqjuWZ+sDAexMUthFBrXbCE4blroRveqB4qje4xPJt57
	fHnQTWJJAFiwBmrxEQFZSPLXhJbm5O+fN93sASXyEQbqE0SXTjM98r3SxoaDEkJEvc6JiNWz84t
	x5uZ7SoqRgupkrfqEwKG0oImKHT5S8aYcKW3TvsBSXa/LVscTHq+BY9TmxpfqWj3CvpCtVP+Lwg
	gouOIa1cSJ632kS3iAuzkS1bvpZ/4D6UjsdOhf9nTf3cd0VKGPXMxQX4Aj8PxlJ0wdbkF6mPn1p
	mOY4PsdiculAvsXtu4682P6lYU6EEMvHfh7k/
X-Received: by 2002:a05:6000:230d:b0:439:84ac:56e4 with SMTP id
 ffacd0b85a97d-4398d82ae57mr4494934f8f.2.1771992340075; Tue, 24 Feb 2026
 20:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218092002.147306-1-mahdifrmz@gmail.com>
In-Reply-To: <20260218092002.147306-1-mahdifrmz@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 20:05:29 -0800
X-Gm-Features: AaiRm50hIgWAVdyuR2Vku851sxqq7il1PWJsM35jT1Q6WLt9SSiWvlaXKFRgpIU
Message-ID: <CAADnVQJdQ5PpHRvYahuSk0=cYBXnf5Z9tkdBLs1tcnasigrntQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix selftest/xsk single test selection
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260753-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,kernel.org,gmail.com,iogearbox.net,linux.dev,google.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,man7.org:url]
X-Rspamd-Queue-Id: E451B191756
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 1:20=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@gmail=
.com> wrote:
>
> From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
>
> This commit fixes the integer parsing of -t option. The cli parser
> only relies on errno to detect parsing errors. The manpage for
> strtol (https://man7.org/linux/man-pages/man3/strtol.3.html)
> states that the said function "MAY" set errno to EINVAL in case the
> conversion fails. Currently on some systems, this leads to a silent
> failure with return value not being exactly documented in the
> manpages (probably zero). The reliable way to validate the input is
> to check whether the endptr has been bumped all the way to the end
> of the string or not.
>
> Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
> Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> ---
> v2:
>   - fix style issues
> v1: https://lore.kernel.org/all/20260217080326.50564-1-mahdifrmz@gmail.co=
m/
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/sel=
ftests/bpf/xskxceiver.c
> index 05b3cebc5..5e4095fd1 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -200,6 +200,7 @@ static void parse_command_line(struct ifobject *ifobj=
_tx, struct ifobject *ifobj
>         struct ifobject *ifobj;
>         u32 interface_nb =3D 0;
>         int option_index, c;
> +       char *eptr;
>
>         opterr =3D 0;
>
> @@ -248,8 +249,8 @@ static void parse_command_line(struct ifobject *ifobj=
_tx, struct ifobject *ifobj
>                         break;
>                 case 't':
>                         errno =3D 0;
> -                       opt_run_test =3D strtol(optarg, NULL, 0);
> -                       if (errno)
> +                       opt_run_test =3D strtol(optarg, &eptr, 0);
> +                       if (errno || *eptr)

This is unnecessary. It was required we would have hit segfaults by now.

pw-bot: cr

