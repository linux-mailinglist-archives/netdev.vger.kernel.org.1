Return-Path: <netdev+bounces-27626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D5477C94A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 10:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B670F1C20C57
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372EBBE63;
	Tue, 15 Aug 2023 08:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73323C0
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:22:42 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8630B3
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 01:22:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so48062395e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 01:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692087759; x=1692692559;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=//hkZmPzyjCfUz2KseLJMfFDCNvYPkUyCN9ZUEnPVBI=;
        b=MU9Q3y0dTpSQuSgIz51SVWquDXs3x693pVc76pWW9010mghck3dBXhu4b9MSv/MAK4
         IhFWbxwTTenW4lcn4Q608T9gd9NmuMaOrPqpGCwEQrfo1fM7oQtxKglR926UzZ/hl5EN
         x8Fe0HOaSag74cGaaJh4YlaS4GLS0TQpNjOaHFJuZZ5N6Y6bCV3Wze90V8nRGQ0f64j2
         BD6wLStzWGIrZ8MvDN5+mLBk81gejkWPHzVPmzTaFrgdX8j30KuR6GsdP6utdbJfSJ0U
         IcJM6n6XruUJevVvkFoxYuAx9KRW8uMJMxLrP83Kot+p0jEDZspdhB7MLu8RBrawRLT7
         OR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692087759; x=1692692559;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//hkZmPzyjCfUz2KseLJMfFDCNvYPkUyCN9ZUEnPVBI=;
        b=ZosEf40p/VfyAdEO7kvfowp4s8edGjWNSjf7zecRaZVCOu/ERT7UlfHapk0ft+K1MK
         sirS5BQ3WYDMG7/RK68s1q8p5U1oU/3mceBEc8w4MCJYoLe9wauD1c8lvXaWwgsM8hcr
         9k1A0F4oJorjMwi8W0XIPP8aGFPa5bzhc+HK4ykiFxycNtJ9Zb2NrIhLbhr6mOdAhheM
         X5YEXY6KesCqhMSq3M6mdCjJ/ZFTtJn/K5Bb9WdAVqnzY3hAhWMSGRRH8CLCexRhgV8e
         PUrm+RX84ssKmkczEeOLt+aa0r0g9SrEsLWPDHNADFWFsvWx+PvteQoNgp0l8FaT+52E
         azRA==
X-Gm-Message-State: AOJu0YwkM77vAfpgv5pdwI+qdAdTBct5fOxKRTsZhdphxG+tJnI3axZ0
	pzfcNaUW4KmsbKSSFMe0KdZNn3NToE4dsg==
X-Google-Smtp-Source: AGHT+IGK2/07Z9OFwl5NeNujebkTVHLpYZ5lQsag4z2dGmjkxZxMQxIt79qFhTKXR+qF/l2FMx7jPA==
X-Received: by 2002:a05:600c:ac4:b0:3f5:146a:c79d with SMTP id c4-20020a05600c0ac400b003f5146ac79dmr9421865wmr.15.1692087758901;
        Tue, 15 Aug 2023 01:22:38 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:9934:e2f7:cd0e:75a6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003fc01495383sm20067042wmo.6.2023.08.15.01.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 01:22:38 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 2/3] netlink: specs: add ovs_vport new command
In-Reply-To: <20230814205627.2914583-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Aug 2023 13:56:26 -0700")
Date: Tue, 15 Aug 2023 09:06:56 +0100
Message-ID: <m2sf8kk9un.fsf@gmail.com>
References: <20230814205627.2914583-1-kuba@kernel.org>
	<20230814205627.2914583-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> Add NEW to the spec, it was useful testing the fix for OvS
> input validation.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> ---
>  Documentation/netlink/specs/ovs_vport.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
> index 17336455bec1..ef298b001445 100644
> --- a/Documentation/netlink/specs/ovs_vport.yaml
> +++ b/Documentation/netlink/specs/ovs_vport.yaml
> @@ -81,6 +81,10 @@ uapi-header: linux/openvswitch.h
>      name-prefix: ovs-vport-attr-
>      enum-name: ovs-vport-attr
>      attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
>        -
>          name: port-no
>          type: u32
> @@ -120,6 +124,20 @@ uapi-header: linux/openvswitch.h
>  operations:
>    name-prefix: ovs-vport-cmd-
>    list:
> +    -
> +      name: new
> +      doc: Create a new OVS vport
> +      attribute-set: vport
> +      fixed-header: ovs-header
> +      do:
> +        request:
> +          attributes:
> +            - name
> +            - type
> +            - upcall-pid
> +            - dp-ifindex
> +            - ifindex
> +            - options
>      -
>        name: get
>        doc: Get / dump OVS vport configuration and state

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

