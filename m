Return-Path: <netdev+bounces-280551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OJ4DOVC6WmqWwIAu9opvQ
	(envelope-from <netdev+bounces-280551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:51:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A3A44B24E
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D7CF302F410
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34F3A3E81;
	Wed, 22 Apr 2026 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPL2z4cY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283F3A1E9B
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894688; cv=none; b=F2Ve6/z+gPcykg+diP2JD9VS2/0UiUzORKrmEScgf4CJRratpthtKlR1BV/pkqXRgw/F+OLzrwcuxMorfx7HEqIEIe2HK8IOJcNYHheQOOU3YwAkjggdryAyCw7HrcWdtnlWpnGezfVhWnPa9qaTI/OC6x4xl0td0zrR8YtcJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894688; c=relaxed/simple;
	bh=xLR7/Wot+FXZ1Ew/rIkiouhKCMOIbSMG6rMeuY6RhSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxJTXnkdgIM7zGj+6Oes8iyBsSke1TofiSiJWlYGEu+axipGBe3y68ufuxYtElDctA/fmt+Fz91ox6xXikoFDtFO/F67zJVn4W/I+wZIaG5HZH38apzN17bZPAUS/29nzTGNYhOPZ3nFKZyKTDr/4UkfEE+rTrXhrkRWX3Ea89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPL2z4cY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf7683a28so4056857f8f.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776894685; x=1777499485; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9npoNohnanVNqr3tknK64s3YC/XC8dcwMAoGONJ+baE=;
        b=DPL2z4cYor+QQH4TF5gXU+aI2Ks4XHr/orJCwc+n8nPdV30R+ltbdooJ2LjiEoqYv4
         oeJlbq6cWS4xcN9URHpLucD5D/FfEijeWmp3+zi4FbbdqkU6dJif1AuDpf6YmU+R56eY
         JscA24tMqMhqWNdK2bgPrxmQYNWlXNGck2BgiruVea/BDmpv+TyB6E5qlGA9bOOy1IgN
         YE1cVsZrCmbCkxTA1JVoHs+H80j8lDEqKvfrwiC3/FQSG/XizywH1Ssf5WYjHBcn2lUa
         13lLs7BAdGNlNKQO1NuUcBUwlqOq4r7J0Eiu4JND+6NHrQ820mz2cPanHDaT38FdI56m
         l1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776894685; x=1777499485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9npoNohnanVNqr3tknK64s3YC/XC8dcwMAoGONJ+baE=;
        b=OEEWaZLzGPlCpw6UiOe/7eeg/z4TqM03N7SjRX3MndYGWTmw0S3dMKANPr7pAc7kT4
         NR+suhlRt04YLay6/Yy/hCE/q7a9Y6yhnQKm3bRzolNWQKw2ryZwV4qBKBOS3njH9ui/
         lMEZIohZuzMU7fHQYyXYY02EjuU8UDfEdhGdNIWN60a3jgWZ54VPJv+e2RnK5FzF+mFV
         YBiWwxHwdhRWo2k3731lpQw98po1FpOwvUhCtAr5Tqk59EcLsI1Qhj6XUSLcCokpaAOw
         1mRgbSUwCw3p7s0wctMbWVzCl9n86n/Nlv7lO9nYwXgtkNlwhakLXcNZSY3Hn88qNF6a
         qaCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YYb66MhEV0EGMGgJoXZv5reSlG8an4DWWDR3f5xdH5BLplclhLu+F7IduesZxOtFuQ7gV2ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+18+PPQyIgqPeML0q9dDkhZfbu9plWu9lQdfC4ThYCW9jy0WZ
	XND4cx9SgjrsbTayU/uGOQdYHTQfbjfSC2nmyvdD/urfe57x6xCrJY7x
X-Gm-Gg: AeBDieuRUPMeV8LJwuGGoQkwdO7J7HC8FtYmq3+PxLb2Kb6sLN7W8UsObaI1Q705uNC
	tBodmDj4BY0OoXMBpRJOhakrAKDqVBqLZ/049Ao/Xg5X+tbpeUnhgyxxMsIYm8EPvmf7/7TcadJ
	243U4n/CzWs7jUaTfnS/CUQZsc/yx6Mfnf/Czs9TNJ8euh8VVtXswNrGzuNPGILSn1uAj5QCGnU
	8NiBDpt8UQI9+xoAtF5suEsu1cLI5iDCmG9U5ryvVezaPmU4EZvIVxGtXnhCiRyWJuVKyIjDCRe
	7OHyaaqGf/6saNx+HEohQq/tm//jNOfixL/axh4N2FmsCGnOiZzSJ0f66MWBl5P1IUTHHR9Ra7A
	M7BBQvrzMdCFoMQ7aNc+FR6s8kjJ1R6DB1nsWGJXmzUCAcNef6iri0cZcgKSvX5lRb3qhH+hg2d
	PxBq0pNMG9miwh7R8y+87rIIjxP0CMvQzUCGXRGXOpxlieLQExJW+JcdBMCmZfT0xhQTQgrBd6i
	8Ml4nvS4aoK0dsvfOc+SJ/RYoVanlifw1RmEw+UlninHNoMcGOUYUrS+aogSyIaqTiQ/Ab8x1ZP
	SoT6hCV0HwPKDn3DAsAKqCJ+SwbIN7X107ZPic79nwRPTJ6yd+d+gqldI1CDxe4=
X-Received: by 2002:adf:e789:0:b0:43f:e94a:e773 with SMTP id ffacd0b85a97d-43fe94ae82dmr22387800f8f.27.1776894684917;
        Wed, 22 Apr 2026 14:51:24 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00069634438ccb7ad1.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:696:3443:8ccb:7ad1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44123d23e0bsm9675361f8f.15.2026.04.22.14.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:51:23 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:51:22 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, ebpf@linuxfoundation.org,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: make btf_dump use
 xdp_dummy rather than xdping_kern
Message-ID: <aelC2iC_KbIq5jwx@mail.gmail.com>
References: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
 <20260422-xdping-v2-1-c0f8ccedcf91@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422-xdping-v2-1-c0f8ccedcf91@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,fomichev.me,linuxfoundation.org,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280551-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A0A3A44B24E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 06:20:24PM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> In order to prepare xdping tool removal from the BPF selftests
> directory, make the btf_dump test use another BPF program for the btf
> datasec dump test. Use xdp_dummy.bpf.o, as it is already used by various
> other tests.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index f1642794f70e..9f1b50e07a29 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -1027,8 +1027,8 @@ static void test_btf_dump_datasec_data(char *str)
>  	char license[4] = "GPL";
>  	struct btf_dump *d;
>  
> -	btf = btf__parse("xdping_kern.bpf.o", NULL);
> -	if (!ASSERT_OK_PTR(btf, "xdping_kern.bpf.o BTF not found"))
> +	btf = btf__parse("xdp_dummy.bpf.o", NULL);
> +	if (!ASSERT_OK_PTR(btf, "xdp_dummy.bpf.o BTF not found"))
>  		return;
>  
>  	d = btf_dump__new(btf, btf_dump_snprintf, str, NULL);
> 
> -- 
> 2.53.0
> 
> 

