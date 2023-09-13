Return-Path: <netdev+bounces-33471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F779E12D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDCF28193D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172B1DA2F;
	Wed, 13 Sep 2023 07:51:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B93D6C
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:51:26 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6DB198A
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:51:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so6571670f8f.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694591484; x=1695196284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uh1ntc2L7ub0UvD6ttcXR4uJj1o1BvAK9Thuxa3o2JA=;
        b=A9uO6hwhO5ISHJQ6QaU3EkNQX2P998YmX04nvne7QBAttgXUSML76cR825BZl2KYD5
         LBzmX1gEdXh6FxGEvn9+BKkbQy0HHNyx0XOyVNffW+yYQCxYAzmjAv33VdNnbcRSNkYb
         ebmh3bFCkil2YzW8TRVI1TA+92+ApO5D3J+LYjS8+s32Ee6YI/GeMrNquLr8CUCAmXHe
         sN83I66YDXeDSPtnykxe7X2tCh4eEGESC9ryS1FvId/fe6/es9aCbPlvOlVGjMCQdWtO
         mtayNq3hDCDXrTrXC/VzG22YCXwKDFTDVpgoB8ttoUTQSsj2C/WpX7l8/kQbyyvFsrU7
         nFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591484; x=1695196284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh1ntc2L7ub0UvD6ttcXR4uJj1o1BvAK9Thuxa3o2JA=;
        b=lHMDIWJIgFcyWD7ARxp9Ctmy0+YD0+FgmH1Xy1lz6qHTmpprcrlr5UFWdmaKfHEzjx
         D2svBVtIYgJA4INDIaz8jFAqAGhZ/DDgVCq5fPXvG9oid+bUElwL0QyUojYTTQ496Y7p
         oM4oxCOEbcy3GuEpykaWk7FIiABSc8xe1ipjYVlydKpb6WevuJW7OnJVInS3XE6JcQuG
         ujOyfI4PhN7EzinWXE8yrXaEPs15gSOvHtzzYSLeV3q6s0nUdRohvcZXko6yvZ1Tytx/
         DOJylFFiD16ym8kIGib4Yya55k+o4V8/elSGEPLu3m6BgRCpn3h5NSODXGWNlNcxTqq9
         oKig==
X-Gm-Message-State: AOJu0YxDP046HDNPkCcZYjT7uD31Ucd6wFCZYeCLMiat7gH7OVOk+N6I
	kzuI1VJWPKP23L4QnDdlZiJBhQ==
X-Google-Smtp-Source: AGHT+IHF+2dwaMPL/NJgISA6fL6Zq3XQcD2KXmnJ2/CjAn4t1i4zywjEdhKSJIKJPhEE+FvNHC5Zvw==
X-Received: by 2002:adf:e78c:0:b0:314:1b4d:bb27 with SMTP id n12-20020adfe78c000000b003141b4dbb27mr1364991wrm.64.1694591484390;
        Wed, 13 Sep 2023 00:51:24 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d4bc9000000b003180027d67asm14707611wrt.19.2023.09.13.00.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:51:23 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:51:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alex Balcanquall <alex@alexbal.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: thunderbolt: Fix TCPv6 GSO checksum calculation
Message-ID: <ZQFp+vdoedzshCpZ@nanopsycho>
References: <20230913052647.407420-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913052647.407420-1-mika.westerberg@linux.intel.com>

Wed, Sep 13, 2023 at 07:26:47AM CEST, mika.westerberg@linux.intel.com wrote:
>Alex reported that running ssh over IPv6 does not work with
>Thunderbolt/USB4 networking driver. The reason for that is that driver
>should call skb_is_gso() before calling skb_is_gso_v6(), and it should
>not return false after calculates the checksum successfully. This probably
>was a copy paste error from the original driver where it was done properly.
>
>Reported-by: Alex Balcanquall <alex@alexbal.com>
>Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
>Cc: stable@vger.kernel.org

Interesting, it is not actually cced. No need to do it anyway.


>Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

