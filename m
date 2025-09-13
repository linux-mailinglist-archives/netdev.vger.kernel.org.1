Return-Path: <netdev+bounces-222749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA1FB55A99
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF7B1891314
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3292BEACE;
	Sat, 13 Sep 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyBgXnjE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F67C2FB;
	Sat, 13 Sep 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722796; cv=none; b=gU4eBiNMqx/+L1+J6/xZT+HpM3CDKNWovkx25MGU/varWI53DIw/yBgOyBqd9SQrvsazP9+cxoYqTx4L/72TZeV5rfe57XEJpv7qH42+2t/k+Ap0I1zmg0CSVGcPclnHzl3WFcZiIAf/GcGExzUpt69gTiZZaspmK/J+jNycZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722796; c=relaxed/simple;
	bh=o1QSNiz0UzcqavKMQnmLCDRESQ6DZ5RarZ2P71WApQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8g6e48RIWPzvBplOpdSt+UEDqpYo7L3MQtEGNcOvhcUqLmyb4L34uyLrKC5zRvJtfmUaDu4HB5eOd9EA65rTuYJVwlL3DVXkpJDt1B1pI4LrziTrWUqWo+gPZTrJXtMTaNOqQNoeMqUtsfKfyQWHLWsMXmf9+QT53HCBzLXkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyBgXnjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D336C4CEF5;
	Sat, 13 Sep 2025 00:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757722795;
	bh=o1QSNiz0UzcqavKMQnmLCDRESQ6DZ5RarZ2P71WApQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KyBgXnjE7P3nLM/EVnF+DOZqxinRKhuWogvAhX5DeUtn7sT0o7E6jr4uBdSCCztWE
	 2xmV3ca+MS2rMFK8zuWMLibQkK+K1NpltJKuXlLdDqsLxNTjkMSzsifAkG6WH5Ul/w
	 ChNRvlCQUcUjksYtWdGwiR71S3c9ISkPft1eUMarjh2sRXZiiEuOB0LbgLeQRq1pYn
	 kzdG03teeE2YMXZt+U6geIh6z+xC8HdiGcPX93/e2P2x/O3x2ZsxDbbnLMugWTnqVc
	 mxINwwZN0wGNYIdRg/e3O57ITLbhbpAe+WTkhtlzYo8UvS+YFXf1AxRZt0ewZlAqCl
	 enN32tbTMURUA==
Date: Fri, 12 Sep 2025 17:19:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/13] tools: ynl-gen: refactor local vars
 for .attr_put() callers
Message-ID: <20250912171954.7c020c60@kernel.org>
In-Reply-To: <20250911200508.79341-5-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2025 20:04:57 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> +    def attr_put_local_vars(self):
> +        local_vars =3D []
> +        if self.presence_type() =3D=3D 'count':
> +            local_vars.append('unsigned int i;')
> +        return local_vars
> +
>      def attr_put(self, ri, var):
>          raise Exception(f"Put not implemented for class type {self.type}=
")
> =20
> @@ -840,6 +846,10 @@ class TypeArrayNest(Type):
>                       '}']
>          return get_lines, None, local_vars
> =20
> +    def attr_put_local_vars(self):
> +        local_vars =3D ['struct nlattr *array;']
> +        return local_vars + super().attr_put_local_vars()

Doesn't feel right. The Type method is a helper which is compatible
with the specific types by checking presence, then you override it,
and on top of that combine the output with super(). I don't like.

