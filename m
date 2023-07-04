Return-Path: <netdev+bounces-15359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A217471D3
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 14:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBF4280E28
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995BE5686;
	Tue,  4 Jul 2023 12:54:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3E2575
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 12:54:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E97113
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688475290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioWPxV9zU1HRZRvRW9KpWYEne0dVnA+bJiiYdIxAOPo=;
	b=TRqJA+PoovPzLrQspKOWYE5BfEZmGQaTpFMyqwoiC1U4Wgnbfcugz8PWXyWB7F2tXTWKwB
	JazqJVI7tjkKD42BDbQleak2+8c0IupQDqKvQJrFHatk5z7sPruumcd1nB4BGjjt/AxklM
	8UeTYov3G94I0B15Pn7w98xRqo8+yIU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-D89RMYLxNmyVAuush1TyUg-1; Tue, 04 Jul 2023 08:54:48 -0400
X-MC-Unique: D89RMYLxNmyVAuush1TyUg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76721ad9ed7so101532585a.1
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 05:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688475286; x=1691067286;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioWPxV9zU1HRZRvRW9KpWYEne0dVnA+bJiiYdIxAOPo=;
        b=K8sJLvHlZ9N2+rSOsk8j9/Lp/HQpIBGuXJABC9o1CFjeTmEl03LYWspVW9I/tvHqro
         YEKeffAuaY2RxsmihA5PmpZZSkA4ojl6ZjWFBKTovGFWa/BmREWHjYxnawT9wczHCGBb
         A5wSC9W4bwPWAQc5wOyfTazqYFdliGGbW28/n3ots5XSCl4xSPi7tEy9dfFNvEzzIuOP
         80N8yG4XA4woxy0JyxJfSMAdQgFfnltCGNp7tMFj0Zb+zvL8z59PThr1DxAy1StRS6+2
         DexheOXcqgIF+AnCDl728mxndwtt7gj/riiNJ+SjeNL7jgZIL0ySO3XS5y+7OUztEuCF
         fRCA==
X-Gm-Message-State: ABy/qLZzQXKXRUonH6urH/ouU954UiodXHTMcRvAiGj9cUApxLAHUCw9
	SKCuJIIe1R7SPfLcTqHDNfMze+hBiGmNUZR4QnrdZv1WGc6rj2CcMTmFXB/NnUe7YngNKWlSnyN
	s6NfvlpagOL/xq4Mz
X-Received: by 2002:a05:6214:4018:b0:635:ec47:bfa4 with SMTP id kd24-20020a056214401800b00635ec47bfa4mr15158354qvb.4.1688475286697;
        Tue, 04 Jul 2023 05:54:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGff3DAVP8rxsCeJdiqdZJEJR0lTXhvEtMOgiBPMRGFUQp2BEEn7tqiM1upp5A0yfH5+B3Pfw==
X-Received: by 2002:a05:6214:4018:b0:635:ec47:bfa4 with SMTP id kd24-20020a056214401800b00635ec47bfa4mr15158343qvb.4.1688475286407;
        Tue, 04 Jul 2023 05:54:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id z18-20020a0ce992000000b006365b23b5dfsm4989364qvn.23.2023.07.04.05.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 05:54:45 -0700 (PDT)
Message-ID: <dfbbe91a9c0abe8aba2c00afd3b7f7d6af801d8e.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From: Paolo Abeni <pabeni@redhat.com>
To: Ian Kumlien <ian.kumlien@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, intel-wired-lan
 <intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Tue, 04 Jul 2023 14:54:42 +0200
In-Reply-To: <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com>
References: 
	<CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
	 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
	 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
	 <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
	 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com>
	 <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
	 <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
	 <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
	 <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
	 <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
	 <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
	 <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
	 <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
	 <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
	 <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
	 <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
	 <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
	 <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
	 <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
	 <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
	 <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
	 <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
	 <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-04 at 13:36 +0200, Ian Kumlien wrote:
> Propper bug this time:
> cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux

To be sure, is this with the last patch I shared? this one I mean:

https://lore.kernel.org/netdev/92a4d42491a2c219192ae86fa04b579ea3676d8c.cam=
el@redhat.com/

Could you please additionally enable CONFIG_DEBUG_NET in your build?

Could you please give a detailed description of your network topology
and the running traffic?

Thanks!

Paolo


