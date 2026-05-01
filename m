Return-Path: <netdev+bounces-283236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AT2N0LR9GkYFQIAu9opvQ
	(envelope-from <netdev+bounces-283236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:13:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B164ADFD6
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFF2F3043515
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0AF3F7AA0;
	Fri,  1 May 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuDKym33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC903DEFFF
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651909; cv=pass; b=BHlJbvnEaxf9Kc6u8d9dLGIMqJqWUdmPPtA5XegAyEvyjM5PI0uFQL1JBdIcrF8tcqPKwL9SVALr4bTSfEOzXtpIBkBpANgHaBVFwRKAKEhnXfihDiOh9kA6Mcx+pyKTLQwEKzjkWuTxDMImCxCeOfaQNPB6+aUwBbjCmBMvEs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651909; c=relaxed/simple;
	bh=Lg3I4a5CVSLmEfFpzSrc+IJ6RbdpOOFMUy6frdtkKdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0kh15yOw2iodu+90qgNV7V9PddBs5NYxkbuhZ43j5uhbc1VSG/G37p9Orx/S3TipczuCyZhJBu7riqr3avU2FUbgM2o9Ye++TnS2ow//oG9S2NrbsQgGGxH38RdEVHR6uA6+cZYypjPoZGr9nso23bjx+sxD3YmtE1jOQSVGig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuDKym33; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c565dd3a7so2914433c88.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 09:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777651899; cv=none;
        d=google.com; s=arc-20240605;
        b=RwnqWr9xV/ceFNiAKQwENYTwnVus90HjEZo4UxukGtoTzZZSYMBEgZvkcyCOKbFaR+
         4q6lKuhB/I2/7BGaAJj9KaFuUfTAhubq2GsL7ZGSGGJyw9SL0H963ozINsVHEMbDblSu
         I9/Trfx5NKvPDDrssytDOIWvfVZ1FjShJuezdSQDmPxlE2wYWWv0ekPJt40erujBqB5J
         cDFo+eTDRkGK55/uXiRTHZbBAXzKxfdFbORDuuTgabEjF9876twpfADzaVe5pGY6fCuR
         wtjC6A6lXaekb4hDZgMn0gd7sH3YC9z0AD8w9vyXpcGO53NKeFYhLnmD6HveA3gAfTAR
         lUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qUtLnk45BiKrXHINpVcyMQeBwCn16A0KrBFa2QFTWtI=;
        fh=xfrZAEFk+gwESRlweNHdT400HdgrQxt/8Pgxxcq3pvM=;
        b=aYUnSkPnCWahXWG/h2SP6630vn0BGe9flLCb5W4Jd0CUJthA6aptMtRjlQw9CcxJIi
         pwBrg6pK2x928Tnl28I204d2nuurplck0pxq2Z0knNT2VULugWf3wQJjyuKWXGmGNS2l
         2aKhw+wroyo2dnZn3+E+2/jefMTbV8K9Y8DOgWVoYr2/vvGliLg9Z2vIKi9Jp+EGYZfV
         wPRY/f70ubLvSsEPm6/o7Yc2NGyvQti9OD98xbEEioMMTVEo4oyvDEq+Wv8R+UB23gr+
         sr+5vnoMD/uC0qYfCqN7w8/kuCqUqDFTr4XuLAZiuAk9JjwUhPG3JEBOVnokKjY6aDxw
         wZ9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777651899; x=1778256699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUtLnk45BiKrXHINpVcyMQeBwCn16A0KrBFa2QFTWtI=;
        b=iuDKym332S3y8j2Dh8gx5+R6x5q9ow83jxo2eSebtwLzoL7A08OmajBfhFzWCdKifv
         tSC2/qCqb0EUCeKQDXArWwsFbvxZshdj6+YxZkOwWJCHAlm9NTkqeDbUD5DhrBf+uT8b
         7OVSxiC+3KhCsYvtennSRH1IZs6NYrEzCC0WKMmPy12hYAmghoqQEMvJSKgRc/MER5jp
         SdoEm9F7/eDVT3mm6gVwb+36REfhqT1KtcCZSynk5T8jlVrrv2iHBADepDV4W4Fny6Ce
         VqcOd4HzKiBmsbe9OdD/EaQKN8No8kqjD+EfMrTpOxVlFahLEr+8c0miMiEYERdd7FJz
         H1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777651899; x=1778256699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qUtLnk45BiKrXHINpVcyMQeBwCn16A0KrBFa2QFTWtI=;
        b=ZZ/jarpZUuB30/gtvuUakiGYoYZ0iqGOQSnQE2O/uIjeGB32dfbsJ6oBB6DW4BkCj4
         h295LWek8FirJmCThjpccASWdr75Cb11Gw5/8FAJPqwrO+2LHEtXld8Mxas73BSxOqcl
         wS27XhWtJmiBoWlJT2RQwnsBarLO4cfbU4eZmLiXFWH9ODhLbklsr5CRQuyIQduUScMN
         FjcOut+lHUVhQ/a0adcwrI+ZIdPE2Jl+cnNl27NXKrDdPqAXn3h6LLjmtLv4Y3qXOplC
         yrN4nur63zspRJOyzVj+wXO5Or8PewbsMAkYPZQpcjgC0fEorAkU0yWZLBAQmthQvYEj
         qhbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rjRoOwXEjgzKwl/PKObQob8CwSJsL5EaNrPvl7E6UvqJ5vcDYaiVoRP0y0/xWEnBjPZvpmCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEeOUE1AbXlLsTG05Xy/BrWSekkGoTCVEPi0kAuRYjY8/e5CaP
	IiQvlXeSi+Hddsc7EvDILym4lxTGPWNlsxV2Fzyh4/pgDyfZSDdjWtUbyew2hqadvkuoOe/OQEw
	XB8Rrz0w7mt970CDzGXkt7t69H41y8K5dpHM3Ge7I
X-Gm-Gg: AeBDiesBCFPuAuGZdRZGP6C2LBZ3WCTQmy8yU1JhxeHXivRyGdQrzIv0aTKU/k3rS5m
	+H1cuqg8XeQrrjzO8hCsIEF30eaOyKdMSmAANHXmKHD+DExa1zhXMhl2Huxco9XfweSWxqBYcFw
	yZfrr0k6UrcZC4uSRhfBRF9qV4Pvr9wjOFqQQcF8r5BIcQoOTRnaUHgpIIy04iMh7xtlonjtso/
	DeP8wdYWcl6KQqeritna2/7RaiBkJyz/Lnn98qwFCZaphX3sIKNN6mSm79537hptx7c00XUPHES
	pB+dhZ64MB/b1iQSyycpWe8S2DV4EUI6FkOhfFgV
X-Received: by 2002:a05:7022:423:b0:12d:e126:b7c8 with SMTP id
 a92af1059eb24-12deac411demr3607716c88.13.1777651898369; Fri, 01 May 2026
 09:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 May 2026 09:11:11 -0700
X-Gm-Features: AVHnY4IcOZBEwRDeFauz0p7wo2ItTFGZpUDr4nDVbee6fBs6NBQ1Q0W5r-m7yp8
Message-ID: <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 23B164ADFD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283236-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qemu.org:url,nvidia.com:email]

On Thu, Apr 30, 2026 at 5:08=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Add an mlx5 driver to VFIO self test. This is largely a remix of the
> existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> to issue RDMA WRITE operations which effectively perform memory
> copies using DMA. Since mlx5 has a stable programming ABI this
> should work on devices from CX5 to current HW. The device FW must
> support the QP loopback configuration.

> This entire series was coded by Claude Code in about 4 days.

Very exciting. Josh Hilke from Google is also working on using AI to
create a selftest driver for Intel IGB NICs so VFIO selftests can run
in QEMU [1]. So it's encouraging to see you were able to do it with
mlx5.

[1] https://www.qemu.org/docs/master/system/devices/igb.html

> For those interested, the flow I used was broadly a prompt sequence
> sort of like:
>
>  - Hey Claude, go look at the falcon series, VFIO self test, the
>    mlx5 driver, rdma-core and some PDF documentation and make a
>    plan to put mlx5 under the selftest.
>  - Write an rdma-core application using the built-in VFIO provider
>    that can do the required memcpy operations that vfio selftests
>    wants.
>    (This resulted in a 1k loc C file that compiled and ran the
>     first time but had a few bugs related to device programming
>     that the AI resolved.)
>  - Replace the rdma-core components with open-coded versions to
>    create a fully stand-alone program that does the DMA memcpy.
>  - Review and audit the thing.
>  [Pause and de-slop it]
>  - Make it work on a PF too (this is surprisingly hard!).

Can it work on CX VFs? We're interested in continuously performing
memory copies across a Live Update using a VF via selftests to
demonstrate SR-IOV preservation (when we eventually get there).

>  [Move to a kernel tree and copy all the .md files and .c program
>   it made]
>  - Hey Claude, look at all this stuff and make a broad plan to
>    actually build a VFIO self test.
>  - Here is my 1 sentence advice on what each patch should look
>    like, make a detailed plan to make a patch for every one.
>  [Pause and polish the patch plans]
>  - Execute plan X then commit it [pause and de-slop each patch,
>    repeat].
>  [Review and final polish]
>
> It is based on a tree with the falcon series applied.

Thanks for sending, I look forward to reviewing!

