Return-Path: <netdev+bounces-29736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C56784884
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046971C2085A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5A2B576;
	Tue, 22 Aug 2023 17:41:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD632B544
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:41:30 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5EE5D
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:41:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fee600dce6so31647255e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692726088; x=1693330888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Kt0k4/q006hgk0f0Nq3V51qptn7Dmrz5m2cjTVivU=;
        b=XKLfFGDgF28S/rXbFg1GalwKOd06mEKcoHCnC35VLWWzhD0+tQWiGUNMhWff6HGCMK
         qdfDzWvN3/Qah/1dMLTZ327LhWU7xN8Co0w/oVF7/U7cwgAAz48r7qPP62S0ev/Wu3zx
         iwbkNpKGUyUL86mjLB0x35Yxk5f2p61tncho+dKFTUD13pbpWqjoEZqTpBLK/EikbNuh
         5/kCRiDtR/rdaD/AK+aAhbu+bJCnQxDzMb4C1LytvoiCETtpup9gS5xPEQBanSOcP9Rz
         1WiujZUvE0ztA6OfIdrZotWJ4RAwyjQi0DfWKq+/iqTKkSNWwSDW+sSNFHdO4tRr0hN+
         2Afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692726088; x=1693330888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+Kt0k4/q006hgk0f0Nq3V51qptn7Dmrz5m2cjTVivU=;
        b=V68EIwWrY1WRm7yh6Ec1RCvbqyBPJFBd/WZMfrKEjXjEt5nDFfUWe5009CKb9CHhvQ
         +jq9wkEmXKHfjK0XsCRdpk8ILi5p5hk3JCRH6jLFQMdYA9wRxKNoALhUyN+H51dXucKz
         y9l5ubaPh/oriG7zqKNhBwKqvTczAWUO/ft+1ujivkqiD0cYOxuFZJiTlMFinzgXi01V
         GV3s2GlOVfwLopnUB8FhEifuVxJwzrwsuHF2Zi0bGwaM3PkloOzChI1ESStrVEonyV/q
         38X+3Futu0+eJ2NJESJn8Q3Ztuzcg3OC4tCIkpkKdD05XCFxfdMfKETYhne/KfBswOQG
         9aPA==
X-Gm-Message-State: AOJu0YyMBkofgzmYsCh5JirrlY0J5/CXniUakvfBHtu7xqzdJ5bRWXgf
	3TMlh9agKoGv6a3S/ZJGGZvXsgQvW2xjkRa9pzD+9jme
X-Google-Smtp-Source: AGHT+IGeUlA+Gj+aSY6+7W869r1h5DXugcNQkAJdfRa21gfNS0eP+5uHlNgLhMppD+kMuy6HxTtKmg==
X-Received: by 2002:a05:600c:2307:b0:3f8:2777:15e with SMTP id 7-20020a05600c230700b003f82777015emr8024518wmo.31.1692726088001;
        Tue, 22 Aug 2023 10:41:28 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id f19-20020a7bcc13000000b003fe24441e23sm16431739wmh.24.2023.08.22.10.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:41:27 -0700 (PDT)
Date: Tue, 22 Aug 2023 19:41:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next] tools: ynl-gen: add "spec" arg to regen
 allowing to use only selected spec
Message-ID: <ZOTzRj2o0qQL2dxJ@nanopsycho>
References: <20230822115000.2471206-1-jiri@resnulli.us>
 <20230822100940.6baa7574@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822100940.6baa7574@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 22, 2023 at 07:09:40PM CEST, kuba@kernel.org wrote:
>On Tue, 22 Aug 2023 13:50:00 +0200 Jiri Pirko wrote:
>> $ tools/net/ynl/ynl-regen.sh -s Documentation/netlink/specs/devlink.yaml -f
>
>touch Documentation/netlink/specs/devlink.yaml && ./tools/net/ynl/ynl-regen.sh

Ah, leveraging the skip. Okay, makes sense.

>
>?

