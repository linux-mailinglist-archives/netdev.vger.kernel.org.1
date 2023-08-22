Return-Path: <netdev+bounces-29575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE83783D61
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E8F28103E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC609440;
	Tue, 22 Aug 2023 09:54:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A36FA2
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:54:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC5F1AD
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692698048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxtBhyi28z9pMz+0t9qkaG0U+mSCYszzo/0WfoBzp5Q=;
	b=cm3keUA7pqV8XYtal12aqcFK9KnzkHZfPfwOXHs37mYs+BX52/m0cQQqGzxGjWgcAQCmIY
	IG1NM7rV/Q6K3lor4hUmxeDXluMjf5bTC4E/tlchGVqC8R8cDrNhW8TJfD6hJ+pXLa31gT
	FDKItdRbC7xoiAvUpkp6qjkrVzVnNZ4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-wjg-P_elOGiah_Znv45llA-1; Tue, 22 Aug 2023 05:54:06 -0400
X-MC-Unique: wjg-P_elOGiah_Znv45llA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a1c4506e1eso1019166b.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692698045; x=1693302845;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WxtBhyi28z9pMz+0t9qkaG0U+mSCYszzo/0WfoBzp5Q=;
        b=cl27z8nOySxt/imA2j5Tgoem65akOLbG7jRpgnbVlORFlOCSoJpYRZKGB2x/Jnt4zl
         aOmZh/xQAdDewKUAJk2Db/0D7SRIwoCpLorGQAIik0QQVqMIRHtu54lVUau8se4nRJjg
         nJsL9u737y4hAYUQfaQ8L0J4Fm7jGcxdzjcmiK2ogi+eCp8zvCeSmZ9PjK03i0TvrSGi
         1zaTF7yzC2+Xe5gB/kLjY1y1pIeSH8q8vtls03dyhDVYA1ewx168a7n8v6v4iomTH9C7
         bRFQ3SplpMC1OK1yG7/y1LDmFZST2VqNpO6JmD3JjZpJKbsxbRSHIKaZVC9Fd8uaX/3D
         pzXQ==
X-Gm-Message-State: AOJu0YyQ7CkaNkFYFyyckkKmS5F2y09nYWAHF0R+iK1Mla1KixDihKWV
	0uEQKczF35P9ODJkszbmQ8S1801AxrFmQY7HB1mvWVu8CXQMQcSOySVI289kBEcG1Tx/PaFcO6t
	SG8NFrtrp9sdHppGv
X-Received: by 2002:a17:906:7396:b0:99d:acdb:f709 with SMTP id f22-20020a170906739600b0099dacdbf709mr6596156ejl.5.1692698045299;
        Tue, 22 Aug 2023 02:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMw7trZ7YnoqKkhLKzk+LlACWlOj7VO2CYqlLqrb9qWTCKeAd+zskdgmkQWS0sfU9B6gCvvQ==
X-Received: by 2002:a17:906:7396:b0:99d:acdb:f709 with SMTP id f22-20020a170906739600b0099dacdbf709mr6596148ejl.5.1692698044891;
        Tue, 22 Aug 2023 02:54:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906705000b0099bd6026f45sm7998879ejj.198.2023.08.22.02.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 02:54:04 -0700 (PDT)
Message-ID: <e0e8e74a65ae24580d3ab742a8e76ca82bf26ff8.camel@redhat.com>
Subject: Re: [PATCH] ipv6/addrconf: clamp preferred_lft to the minimum
 instead of erroring
From: Paolo Abeni <pabeni@redhat.com>
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org, 
	jbohac@suse.cz, benoit.boissinot@ens-lyon.org, davem@davemloft.net, 
	hideaki.yoshifuji@miraclelinux.com, dsahern@kernel.org
Date: Tue, 22 Aug 2023 11:54:03 +0200
In-Reply-To: <20230821011116.21931-1-alexhenrie24@gmail.com>
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Sun, 2023-08-20 at 19:11 -0600, Alex Henrie wrote:
> I tried setting /proc/sys/net/ipv6/conf/*/temp_prefered_lft to 1 so that
> the address would roll over as frequently as possible, then spent hours
> trying to understand why the preferred lifetime jumped to 4 billion
> seconds. On my machine and network the shortest lifetime that avoids
> underflow is 3 seconds.
>=20
> After fixing the underflow, I ran into a second problem: The preferred
> lifetime was less than the minimum required lifetime, so
> ipv6_create_tempaddr would error out without creating any new address.
> This error happened immediately with the preferred lifetime set to
> 1 second, after a few minutes with the preferred lifetime set to
> 4 seconds, and not at all with the preferred lifetime set to 5 seconds.
> During my investigation, I found a Stack Exchange post from another
> person who seems to have had the same problem: They stopped getting new
> addresses if they lowered the preferred lifetime below 3 seconds, and
> they didn't really know why.
>=20
> The preferred lifetime is a preference, not a hard requirement. The
> kernel does not strictly forbid new connections on a deprecated address,
> nor does it guarantee that the address will be disposed of the instant
> its total valid lifetime expires. So rather than disable IPv6 privacy
> extensions altogether if the minimum required lifetime swells above the
> preferred lifetime, it is more in keeping with the user's intent to
> increase the temporary address's lifetime to the minimum necessary for
> the current network conditions.
>=20
> With these fixes, setting the preferred lifetime to 3 or 4 seconds "just
> works" because the extra fraction of a second is practically
> unnoticeable. It's even possible to reduce the time before deprecation
> to 1 or 2 seconds by also disabling duplicate address detection (setting
> /proc/sys/net/ipv6/conf/*/dad_transmits to 0). I realize that that is a
> pretty niche use case, but I know at least one person who would gladly
> sacrifice performance and convenience to be sure that they are getting
> the maximum possible level of privacy.
>=20
> Link: https://serverfault.com/a/1031168/310447
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

It looks like you are fixing 2 separate bugs, so 2 separate patches
would be better.

You should explicitly state the target tree (in this case 'net') into
the patch subj.

You should add a suitable fixes tag to each patch.

> ---
>  net/ipv6/addrconf.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 94cec2075eee..4008d4a5e58d 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1368,7 +1368,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr=
 *ifp, bool block)
>  	 * idev->desync_factor if it's larger
>  	 */
>  	cnf_temp_preferred_lft =3D READ_ONCE(idev->cnf.temp_prefered_lft);
> -	max_desync_factor =3D min_t(__u32,
> +	max_desync_factor =3D min_t(__s64,
>  				  idev->cnf.max_desync_factor,
>  				  cnf_temp_preferred_lft - regen_advance);

It would be better if you describe in the commit message your above
fix.

Also possibly using 'long' as the target type (same as
'max_desync_factor') would be more clear.
> =20
> @@ -1402,12 +1402,8 @@ static int ipv6_create_tempaddr(struct inet6_ifadd=
r *ifp, bool block)
>  	 * temporary addresses being generated.
>  	 */
>  	age =3D (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
> -	if (cfg.preferred_lft <=3D regen_advance + age) {
> -		in6_ifa_put(ifp);
> -		in6_dev_put(idev);
> -		ret =3D -1;
> -		goto out;
> -	}
> +	if (cfg.preferred_lft <=3D regen_advance + age)
> +		cfg.preferred_lft =3D regen_advance + age + 1;

This change obsoletes the comment pairing the code. At very least you
should update that and the sysctl knob description in
Documentation/networking/ip-sysctl.rst.

But I'm unsure we can raise the preferred lifetime so easily. e.g. what
if preferred_lft becomes greater then valid_lft?

I think a fairly safer alternative option would be documenting the
current behavior in ip-sysctl.rst

Cheers,

Paolo


