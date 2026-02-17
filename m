Return-Path: <netdev+bounces-258987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL/gCQQqlGlTAQIAu9opvQ
	(envelope-from <netdev+bounces-258987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:42:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B814A11C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57F6B30221EF
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097D2EA731;
	Tue, 17 Feb 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbICgqJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3C2E7648
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317717; cv=pass; b=WgZy89UN5GUIwB702SOto4W5Qby28DhZwwENi5dXSP5JgYnqOjzVwFngUhAcyyivSnggaujMUwfZa/RZLokgGWqnD8J9xZ6zqBJHwFqKN5p5Yr9vpvEZrGtrywyq9uyyBywWYHdpPgQBqbhqhazTYapm7sNsSqydYRHESVzlbAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317717; c=relaxed/simple;
	bh=sr6l2sn/cCWgbkqXNE2elTu4FxZydQ8A6+cup3YppOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+y5MKNVXIztrSch+OiXKnLbQ4jVkCtgZcFCyNf1/ssz5aJxWNEi2Y+fdK1Tpjieys40omR4xzrqQq5QHMB6aif3JJbHzfB2/DnQPc1nmPgC/k5EiywUzfUq9SeGIR5M/HHzG3YJl5yiVac+uUmXBxVaq2IJPxD3F6sVu8RDMak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbICgqJV; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-797afd2e872so22327527b3.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:41:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771317715; cv=none;
        d=google.com; s=arc-20240605;
        b=iAmAYojUY/jQjEbaWLOREqjhC7EWu7CkrZcMRSmop8im6YN/JZtXEFp6W3tkHPIW2i
         MwFsymzQINFksp/vxk9Mxc7P5axsZqpzR4mSMBhJw25CCFmrd+Fwp8+AZ85lEvgikrX+
         bRKUT/uYpuOt7Rghhg/JNbEa7c8zhj8423rf37IbemocmH59nJHidvoFOzOyvWvMtmgX
         eJfHxg062aT3wmm0+7E7u42AAxAeuGk7WY+5JZQcsoOMwJnwOEZNn6M84OAfQF485SZF
         tyQBlCncMecIxK24BI9FcQhyrHqyp8BehI2g5caEMFPg9Lo/FiU5ABdE+KqsobKPE53N
         Odcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y89n+th7tnE5Z/5/sRNue21/CtYhyjB+0dCF1kUQxSE=;
        fh=SANo7TLZ/JnO2/EWPmJBEVCqluT9V4SL0RWeVtgOc5s=;
        b=S0V5bPXgWYZwIxEpjs7UB32seSyKYEgvmMMGTYNPOcHS//SWY08bJJ8+ZI4+nk8fTV
         yMPym1co8XVNw+VVP6xUwVrx6f850zE7lJm24D2ZG3RqPyAg1w0bedMTXd8k/81aLptp
         1CNYj8zMmlv6T/tBRmZ2yqwAFotlSeTKzy6pkUY7y4NEBbcGbTIIRzQC44dH3VpL32ci
         osX88djnyq9UDBwGsmnPXnF6sZndx2FwZV0NC5yvhzo43haNLUen7ZZbN2OKuD8qAADO
         hc3blzb7EeS4gM0cdtkAwkaXzlPjwwVf8cFGImuA6mrzzznHW6xaRS29bhvHj6MkLcPs
         wL7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771317715; x=1771922515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y89n+th7tnE5Z/5/sRNue21/CtYhyjB+0dCF1kUQxSE=;
        b=QbICgqJVypGY+rE67iWwxINZ9VPBt6f7FQ3OmgVdFSz5foc9erpL3CchYRCIsyjWZB
         5hKrrFtx46yVrPP/Uzn4r0/+Xilh+LPmzL1y+Or6Ly+Vljz5zqtfn72HUH4j+QCelgU4
         IBC6749skHgl4LsUM/FhBfGg3jxEvBVoqvySyYEva2JLRB4eaPXNL7oG4gowbGzpN9jp
         Xm04tYkVdD1INQ2+Rp/v+nlL8IQ+vZNBxOU3addtGLCsKYwvgtrnt6D8c/TVMeEKZPLD
         SR2gRioHWVCDT+BV3oC5cne56hsiwl/Udoj+ITps5vjB7Z10VrEhOEU7gphw+H9TAhDk
         e7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771317715; x=1771922515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y89n+th7tnE5Z/5/sRNue21/CtYhyjB+0dCF1kUQxSE=;
        b=lyiEJcDCxGHTd5OPo/fvRrNZm3d5fyUkUiYlH/N97TUI7luBN2jzf2nvxHuEnCXbPr
         5H5XXW2gzs2O4Rx1dRKg+UBGacHJGGPkwq39Zx49NY8Ga5T0u8/NLQ6zAEMaa63jTDjh
         0fRxPa5yXxNo3Eo3QqrgczGrrUt4WpahcA9C6kq8VkgbSYHbUGt3WIDmePrBQ4JR0L5s
         ecaiGHH3DCOhC88V6E86Ukt0NpK3TOsnIXW3El0lNZLJI7/1mWF47G16pC0HHYjZg0dx
         YNOzzivMeZsAJrYUE+srWC9umpKFo85KUTLuP8TtTlrYtSrAhZVHU2z2RowWGg17fBn4
         845g==
X-Forwarded-Encrypted: i=1; AJvYcCWkeFDRPALjf5cmWhWohKU0wqlPcC+XOUk16nfGaA/dVqErSS+jmGXQv1Siidsy0lK0i/t8shU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwOjYHaAcPMTi1Wd6aBIAFhWm6Azo9JbYFGuVgfkA7wy0R1ng
	IGjE92FA4Zto1QiX8WXV40umIo7GzKQju3nyfdVMJ5koKMIvEh7rWSqazJRNwAvNIDVTiTy7sbk
	vUHNYg+cHehlsJ6aXhth3fshA6ZEajl8=
X-Gm-Gg: AZuq6aJcBGDdKwZ5DSDHgROa7ijnxwTEhQy9F1+WKnM6SkF1REBEp+wP2n+X6GboPVk
	wsPDIW36GFsskI7fP01IgNrbBXFnt6oe8cAPNsR9W1UMrAHkfmXuDelK1OdCLOn9MVfqA3nLXuq
	POTTFGS2cJ56CIN7L2Lf6Lbozwr2YRj5AFla1ccCAyCd7k9aaBEgrQ8ypVIgTf3x+2GtG7HOZFf
	wzGL2J6XvL2/h3aMK2caPD/qJfWb6PQb5heSIaWZDN6QL7AFyrPt7nOOtz3wkFVCsbiKgOu3g4n
	m1weugHaFP/Tz02M2g==
X-Received: by 2002:a05:690c:dd4:b0:796:3515:3aa8 with SMTP id
 00721157ae682-797ac5d49d8mr84544127b3.43.1771317715438; Tue, 17 Feb 2026
 00:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217080326.50564-1-mahdifrmz@gmail.com>
In-Reply-To: <20260217080326.50564-1-mahdifrmz@gmail.com>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Tue, 17 Feb 2026 12:11:44 +0330
X-Gm-Features: AaiRm52mTXMPcaWU90JcdTY1oxO4TzgH5nR25AXCXIXhZJzJg66k_Z4176XU8dE
Message-ID: <CA+KdSGPY3YibWEOEDd6vj+=uQkigUMQDuvBbQZXWWVmnAyV3yg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix selftest/xsk single test selection
To: bpf@vger.kernel.org
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258987-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahdifrmx@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,fomichev.me,kernel.org,gmail.com,iogearbox.net,linux.dev,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,man7.org:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C58B814A11C
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:34=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@gmai=
l.com> wrote:
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
> Signd-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/sel=
ftests/bpf/xskxceiver.c
> index 05b3cebc5..f2d5c4dd2 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -247,9 +247,10 @@ static void parse_command_line(struct ifobject *ifob=
j_tx, struct ifobject *ifobj
>                         opt_print_tests =3D true;
>                         break;
>                 case 't':
> +                       char *eptr;
>                         errno =3D 0;
> -                       opt_run_test =3D strtol(optarg, NULL, 0);
> -                       if (errno)
> +                       opt_run_test =3D strtol(optarg, &eptr, 0);
> +                       if (errno || *eptr)
>                                 print_usage(argv);
>                         break;
>                 case 'h':
> --
> 2.34.1
>
Some style issues and typos, will send the follow up tomorrow.

