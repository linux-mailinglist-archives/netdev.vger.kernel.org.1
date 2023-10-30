Return-Path: <netdev+bounces-45223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8A07DB95D
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 12:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B647D281562
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8614A83;
	Mon, 30 Oct 2023 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HvoOMHM3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF314285
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:55:28 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF322C5
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 04:55:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9adca291f99so652102866b.2
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698666925; x=1699271725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q31c8fnQHD+W10kmomcQ4zTSAMbkT+bVtaWYEa58nas=;
        b=HvoOMHM3zushLZ9gCVFUIC4w7Sq7a2oQf/zsEOrIJiV2h3ds3QAP5QGzzx8OOL+dRS
         sNxzjq1xK1IqleJ0U2RWCPf1GazQcoR38f0IkZvEMevVJHyA7lrZPMVym0p9b1vK5l9A
         Sdi9DCSdHxh/voEzqQ6C7id53wKrCXOXGRDHUpg2aU0N6bKaAcRwrMIhnpm7UWUEkIaa
         z4I+5xiv+JwyPIxKPDtqeE35zVMyQDdmJggjNCCaDZQ5DYE5iHHoPbo541xDR+Fi9MqX
         3QMk8i8gwj7wkGUw5BLpoqX2LZ/cvl+bYuwWfikj2XGbtHwzwZga4wuZxrgtOxfDHqZY
         yqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698666925; x=1699271725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q31c8fnQHD+W10kmomcQ4zTSAMbkT+bVtaWYEa58nas=;
        b=dd42U90sD2FzWX6uPpuG08nUTtp+/TLM4iMp+sXgI28s9z3CJz+9smj9d8+VKGOjOE
         kMoFI6GtZQRuaxeZASjPbieputUvobUV1vZ0J7EEITrHcZpOegpfU3vuJhHS4rYBhQ04
         MDDt1UTP4DiM3diHuqPmseWuS3zPsLSacFEG05XFqLBTEEeKI94O6kBaoUyjgKNbyC4E
         O9NDBpldIIVE+oSY8FjjnEzD21h5T9uV3naBbCxMz4oo0PS2/SU6F2Xo6XbGbFgYe+hn
         3mQvWqcoylRN7NdTevPyS36enfhWQLU4pTUjgoNSBPLrgA0BQWqpalttchJEZ9c181XG
         rZow==
X-Gm-Message-State: AOJu0YwRjkb0b9vq9F/VByMONeCH8dR4PCXweJi0bBbRsERfm9nzuRK6
	6Beu+sR5wfrdKFRl1heumTf33g==
X-Google-Smtp-Source: AGHT+IEK0FVzrhD+/lsg/GFhSKbE3HoxQjpfS+HOYJ/lF5CE71Yh2/i3l6Z4QGe2FLuRhkkWz0rUHA==
X-Received: by 2002:a17:906:c14b:b0:9be:ab38:a362 with SMTP id dp11-20020a170906c14b00b009beab38a362mr8139316ejc.46.1698666925439;
        Mon, 30 Oct 2023 04:55:25 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id lf19-20020a170906ae5300b009ad89697c86sm5944350ejb.144.2023.10.30.04.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:55:24 -0700 (PDT)
Date: Mon, 30 Oct 2023 12:55:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: Wait a bit for the reset to take effect
Message-ID: <ZT+Zq4j9iQj1+Xai@nanopsycho>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>

Mon, Oct 30, 2023 at 07:01:11AM CET, bernd.edlinger@hotmail.de wrote:
>otherwise the synopsys_id value may be read out wrong,
>because the GMAC_VERSION register might still be in reset
>state, for at least 1 us after the reset is de-asserted.
>
>Add a wait for 10 us before continuing to be on the safe side.
>
>Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

