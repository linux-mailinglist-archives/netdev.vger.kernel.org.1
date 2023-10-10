Return-Path: <netdev+bounces-39499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0B97BF8A2
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B5B1C20AF7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69733182A2;
	Tue, 10 Oct 2023 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ+4kAGQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66C171DB
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:29:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D92B9D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696933746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJzuP/A/bgFUoe/uV4FgEOUmqz0biBzCtHevaK0fOw4=;
	b=bQ+4kAGQaMfyobKtf/fpIshX3YNCth/iVPD9lS9xYGuzMHURQ1/w4ZYLOOQpu/rYwnriNp
	tNFTcS5YaE197oKYtC6TIGkqR0E16bDF0zrOYwMa7JsTQ8Ea+qGNoebkudP33zHy5k3uHY
	Ucf3foGleHH1u3IvdC5R0o+YD5lYT+8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-3iroeOrlN0OHwfa3P7wWHg-1; Tue, 10 Oct 2023 06:29:05 -0400
X-MC-Unique: 3iroeOrlN0OHwfa3P7wWHg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae56805c41so134637866b.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696933744; x=1697538544;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJzuP/A/bgFUoe/uV4FgEOUmqz0biBzCtHevaK0fOw4=;
        b=ZW+fZL6zpCDsegmsKpkj7U+jIJtsxRuE8sxJlsmvILmnxtIORMZpL6q9SR4PWsA+uz
         yU5zGr77zxLFVZuCw4hA1Y7qI4UzeNC41VCBTSVh+3VjunAG1VIWdPT6ixc9EpCr42GV
         uIYUwEjzsxbl2VuaguD880vYZtlLdknhLZCN27CNHx8IlldixhKKIRGysDFHy/ndbV+D
         jq0HeT8ogooUbwYTyMrd+YtOu5tMvcygjGmUg7Ci8bUIlqf8iwDZmouTR/GWCE58GC7A
         Wk8kBYS68fj4YHN2ouw+JHUZZk+02h+/j0H4dqjema+7EL6UuCnzMXYdoHV9t9zFJlJv
         iq4Q==
X-Gm-Message-State: AOJu0Yxtu+k3yaUOQTcXgDNOw+mqGPddizpDSuYahzizg2utn0k90OfK
	JF4tdELNIOOCGbDZw77fOIBNGcyVEZlZb4qV/ejpMkSwK92B02PE03VVhJz8o2AEsRi62B7zc+G
	bOSwowqLircww6et4
X-Received: by 2002:a17:907:6d1d:b0:9b9:e641:a978 with SMTP id sa29-20020a1709076d1d00b009b9e641a978mr14820635ejc.2.1696933743924;
        Tue, 10 Oct 2023 03:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8HfWaJOeH6Nh0P9k0lFK1hWlbSTQAqhc5rATKQ4TBHmB5waU8bEDQP4QKKK6bkaoktpmWyg==
X-Received: by 2002:a17:907:6d1d:b0:9b9:e641:a978 with SMTP id sa29-20020a1709076d1d00b009b9e641a978mr14820617ejc.2.1696933743609;
        Tue, 10 Oct 2023 03:29:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b009a2235ed496sm8347645ejb.141.2023.10.10.03.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 03:29:03 -0700 (PDT)
Message-ID: <2e7ee087b33fba7e907c76e60d9eaed1807714e2.camel@redhat.com>
Subject: Re: [PATCH net 3/4] selftests: openvswitch: Skip drop testing on
 older kernels
From: Paolo Abeni <pabeni@redhat.com>
To: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Adrian Moreno <amorenoz@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>
Date: Tue, 10 Oct 2023 12:29:01 +0200
In-Reply-To: <20231006151258.983906-4-aconole@redhat.com>
References: <20231006151258.983906-1-aconole@redhat.com>
	 <20231006151258.983906-4-aconole@redhat.com>
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

On Fri, 2023-10-06 at 11:12 -0400, Aaron Conole wrote:
> Kernels that don't have support for openvswitch drop reasons also
> won't have the drop counter reasons, so we should skip the test
> completely.  It previously wasn't possible to build a test case
> for this without polluting the datapath, so we introduce a mechanism
> to clear all the flows from a datapath allowing us to test for
> explicit drop actions, and then clear the flows to build the
> original test case.
>=20
> Fixes: 4242029164d6 ("selftests: openvswitch: add explicit drop testcase"=
)
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  .../selftests/net/openvswitch/openvswitch.sh  | 17 ++++++++++
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 34 +++++++++++++++++++
>  2 files changed, 51 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/too=
ls/testing/selftests/net/openvswitch/openvswitch.sh
> index 2a0112be7ead5..ca7090e71bff2 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -144,6 +144,12 @@ ovs_add_flow () {
>  	return 0
>  }
> =20
> +ovs_del_flows () {
> +	info "Deleting all flows from DP: sbx:$1 br:$2"
> +	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py del-flows "$2"
> +        return 0

The chunk above mixes whitespaces and tabs for indenting, please be
consistent.


Thanks!

Paolo


