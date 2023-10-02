Return-Path: <netdev+bounces-37471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2155D7B57E1
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C3122284E81
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB551DA47;
	Mon,  2 Oct 2023 16:25:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7E1CF83
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 16:25:34 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB8CA7
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 09:25:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5032a508e74so6571e87.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696263931; x=1696868731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R5LBRkNvnXKP8QY/miZsRIggyAFIMaxHqv5LlPVVeY=;
        b=sAcBv7wJNHfx+gSA1/IngB6sYiaJ3ZJpu7TVtarDYlzCsVz2pWcOvvoWc5IWrj2JFX
         oqK44VtF9hnitBIthCb7HhxYGZdYryCfMuDUWRa4DP85QfD3PV2g9Ecsm1AsCPCK/UrL
         DJOScT47DbGHxYiamVgVdPp4+R9jZQ2jqb8nM0ljaVxz+RXq2tTUIS76fX2l2A10EMWU
         kMLhDPj430F43FlOoD2h8beeRZVlgwnqPuHeIYh6DgG2VtXrgtmoN7mAcUQjtRZWUCl6
         vPeIK5x+2HJdGcnNT4TRIccMjA6Mhs5eUCGUF0Y2G+sSio13mNuSZQ/Xc0mLYlKMAm6L
         zJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696263931; x=1696868731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R5LBRkNvnXKP8QY/miZsRIggyAFIMaxHqv5LlPVVeY=;
        b=ANZe9usmviaowxX88+O88uORvTpQ+SNEMBMZybMsC6AuLEmjo1ScVv8ieac9U3JgxC
         8OqWc+GucmWmiToKtr0zs7iYkOnPMwnRS4rIDCcN3KwCsSpGp7VT2wX4gYFHjnzSN2uW
         K3KOKXQrPGB5y6aB6pzKMmhpDrTMPC0zeBYz7esGZR0xKqkDewVfdttrHRVGXxCdeZS7
         BR5GEhTFd+PWPM2a8rccG4lOuc5y9bbzzCwnldgwPjodabLdEErKbO1V813BlF2uWxmO
         zcqjXwmDEqeei1t2tebjP1APdWclCcrT5dP9exdpZTHvGjB4AbiQJg9UgqgHcPAPd1Hp
         RSPQ==
X-Gm-Message-State: AOJu0YypD7ySAkGzNQcKeMn0qOBwDSxLtqCAWUPoWqJIY1l0tVzjkvTV
	3RWBmiZ9i87ESrnl5y96SUOFj9yYH93cKnXXeT8bcdAU1XhOGWgBxNKnsg==
X-Google-Smtp-Source: AGHT+IEF2GqmeikOd/ZpZIcFXNRTGwfF5n2trr+3c2irQWnFwcteE3ug+GSdA+thikc2k6N186cLZfL4WDuu38YG8rU=
X-Received: by 2002:ac2:5462:0:b0:502:cdb6:f316 with SMTP id
 e2-20020ac25462000000b00502cdb6f316mr75829lfn.3.1696263930911; Mon, 02 Oct
 2023 09:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <881c23ac-d4f4-09a4-41c6-fb6ff4ec7dc5@kernel.org>
In-Reply-To: <881c23ac-d4f4-09a4-41c6-fb6ff4ec7dc5@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Oct 2023 18:25:19 +0200
Message-ID: <CANn89iKEs8_zdEXWbjxd8mC220MqhcRQp3AeHJMS6eD-a45rRA@mail.gmail.com>
Subject: Re: tcpdump and Big TCP
To: David Ahern <dsahern@kernel.org>
Cc: Xin Long <lucien.xin@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 6:20=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> Eric:
>
> Looking at the tcpdump source code, it has a GUESS_TSO define that can
> be enabled to dump IPv4 packets with tot_len =3D 0:
>
>         if (len < hlen) {
> #ifdef GUESS_TSO
>             if (len) {
>                 ND_PRINT("bad-len %u", len);
>                 return;
>             }
>             else {
>                 /* we guess that it is a TSO send */
>                 len =3D length;
>             }
> #else
>             ND_PRINT("bad-len %u", len);
>             return;
> #endif /* GUESS_TSO */
>         }
>
>
> The IPv6 version has a similar check but no compile change needed:
>         /*
>          * RFC 1883 says:
>          *
>          * The Payload Length field in the IPv6 header must be set to zer=
o
>          * in every packet that carries the Jumbo Payload option.  If a
>          * packet is received with a valid Jumbo Payload option present a=
nd
>          * a non-zero IPv6 Payload Length field, an ICMP Parameter Proble=
m
>          * message, Code 0, should be sent to the packet's source, pointi=
ng
>          * to the Option Type field of the Jumbo Payload option.
>          *
>          * Later versions of the IPv6 spec don't discuss the Jumbo Payloa=
d
>          * option.
>          *
>          * If the payload length is 0, we temporarily just set the total
>          * length to the remaining data in the packet (which, for Etherne=
t,
>          * could include frame padding, but if it's a Jumbo Payload frame=
,
>          * it shouldn't even be sendable over Ethernet, so we don't worry
>          * about that), so we can process the extension headers in order
>          * to *find* a Jumbo Payload hop-by-hop option and, when we've
>          * processed all the extension headers, check whether we found
>          * a Jumbo Payload option, and fail if we haven't.
>          */
>         if (payload_len !=3D 0) {
>                 len =3D payload_len + sizeof(struct ip6_hdr);
>                 if (length < len)
>                         ND_PRINT("truncated-ip6 - %u bytes missing!",
>                                 len - length);
>         } else
>                 len =3D length + sizeof(struct ip6_hdr);
>
>
> Maybe I am missing something, but it appears that no code change to
> tcpdump is needed for Linux Big TCP packets other than enabling that
> macro when building. I did that in a local build and the large packets
> were dumped just fine.
>

My point is that tcpdump should not guess, but look at TP_STATUS_GSO_TCP
(and TP_STATUS_CSUM_VALID would also be nice)

Otherwise, why add TP_STATUS_GSO_TCP in the first place ?

