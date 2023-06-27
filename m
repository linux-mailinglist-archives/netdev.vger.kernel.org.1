Return-Path: <netdev+bounces-14323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE53F7401F7
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 19:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB85D281071
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E241308A;
	Tue, 27 Jun 2023 17:16:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ECC13064
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 17:16:48 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C762700
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 10:16:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98bcc533490so573458066b.0
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687886204; x=1690478204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzwHmUu9X/sXaWMwlod4po7vj9xVvh2SXVLW1ypTDRk=;
        b=mUugN4LoYAIgIAfAapAiTL7prcQfjU1nPbUtzyWUoFme2+wJHZ0cvzCO6NOafEpiYT
         0gkwLGIkYvxP3dIKtymrou+XCA97npWDoIA0H8AWRT+j6px2n/8Uylrqa4F4le6hSr4O
         aLYnJaAAXYGnVreJghW/FOjZGE+WLzaocXwsuC8cNUk1kiTFwvCAPWWk47eaYcQFnLQq
         gHN/saMfb9E6fWsmPikwWQPLfHaYVkBxhrfCHBJqQIO4fgOW1dEYc+9Xxza1WgjiFpnc
         P4uR6+iapedkJYPoOE18nBtXXA2aJ+y+2bfIphwNZrtnAJFKlSKawypsGLwPA1qyfpxr
         8MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687886204; x=1690478204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzwHmUu9X/sXaWMwlod4po7vj9xVvh2SXVLW1ypTDRk=;
        b=Dp4JMgSBUPuGMfioX2TeoN/8/jsf2PROIki+EatXmaKZhEn8Mq8sfJX32AVWs2VSmH
         3VZ4jq6AJwiKiHEBsSfSbabSZ9LpBZehriXPWZ28ErsDMyMRiwutI/gi6ISlfSlY1xv2
         Cu5Y3NxVSCggdT4cgMBNiyJ1yLYos0oEDg8NkWtb+ZoyqbOim1u/cZOgoVkgaxTFsgAn
         jGCIIvVBkAKtFOEi3Ro0onSkbpCouPJ1tdEU+PSnWCXCPVKwK8lKCwlpm4xZc3T9LOB4
         lPi3dEQD6Mu0Ntdb/YiUmS7VQ3NT1W1Z9llEmCTwCQNHTx5iKdNEGpZTZUaT3vJ6h5QX
         0DWA==
X-Gm-Message-State: AC+VfDxD1/N4o4DXJTKLLIgHP05+oQfFc7bKmgvbf+6lfqRL9NhG2x25
	80h2Ja5kR54eAC295C0fm9hx9g==
X-Google-Smtp-Source: ACHHUZ6vDB//efr2HZQAx8bvKU78uOE3Gcfu4zIzpAV2o0mwlxHFCUNNvkl08Im8DH4d+NllcomJMA==
X-Received: by 2002:a17:906:6a04:b0:988:a837:327e with SMTP id qw4-20020a1709066a0400b00988a837327emr23409354ejc.71.1687886204517;
        Tue, 27 Jun 2023 10:16:44 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090637ca00b00992025654c2sm1336692ejc.150.2023.06.27.10.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 10:16:43 -0700 (PDT)
Date: Tue, 27 Jun 2023 19:16:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <ZJsZetA02QMmR8By@nanopsycho>
References: <20230615123325.421ec9aa@kernel.org>
 <ZJL3u/6Pg7R2Qy94@nanopsycho>
 <ZJPsTVKUj/hCUozU@nanopsycho>
 <20230622093523.18993f44@kernel.org>
 <ZJVlbmR9bJknznPM@nanopsycho>
 <20230623082108.7a4973cc@kernel.org>
 <ZJa4YPtXaLOJigVM@nanopsycho>
 <20230624134703.10ec915f@kernel.org>
 <ZJq1+ok+WkwePYaq@nanopsycho>
 <20230627082429.36100040@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627082429.36100040@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Jun 27, 2023 at 05:24:29PM CEST, kuba@kernel.org wrote:
>On Tue, 27 Jun 2023 12:12:10 +0200 Jiri Pirko wrote:
>> $ sudo devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 103
>> pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 0 pfnum 0 sfnum 103 splittable false
>>   function:
>>     hw_addr 00:00:00:00:00:00 state inactive opstate detached
>> 
>> $ sudo devlink port function set pci/0000:08:00.0/32770 hw_addr AA:22:33:44:55:66 uuid SOMETHINGREALLYUNIQUE
>
>Why does the user have to set the uuid? I was expecting it'd pop up 
>on the port automatically, generated by the kernel, as a read-only
>attribute.

Hmm, how that could be generated by kernel if it should be really
unique? Consider an example scenario where you have 2 DPUS (smartnic
with CPUs) plugged into a single host.

1) On DPU 1 you do:
   $ sudo devlink port add pci/0000:08:00.0 flavour pcisf pfnum 1 sfnum 103
   pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 1 pfnum 0 sfnum 103 splittable false
       function:
       hw_addr 00:00:00:00:00:00 state inactive opstate detached uuid XXX

2) On DPU 2 you do:
   $ sudo devlink port add pci/0000:08:00.0 flavour pcisf pfnum 1 sfnum 103
   pci/0000:08:00.0/32770: type eth netdev eth10 flavour pcisf controller 1 pfnum 0 sfnum 103 splittable false
       function:
       hw_addr 00:00:00:00:00:00 state inactive opstate detached uuid XXX

There is no way to sync between kernel running in the DPUs.
Both SFs in this example would be externaly created on the host. The
host will see 2 devices with the same uuid XXX, collision.

