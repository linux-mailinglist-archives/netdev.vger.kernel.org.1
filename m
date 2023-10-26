Return-Path: <netdev+bounces-44477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82EC7D836C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 15:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3738BB21291
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A9C2DF9A;
	Thu, 26 Oct 2023 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rAsukQ93"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2F2D049
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 13:21:30 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4644791
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:21:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9adb9fa7200so185464066b.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698326487; x=1698931287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xcSEt7nTMuwkE+QgbNFoQD0oV4mmJrUn9Xh1xHLwJk=;
        b=rAsukQ93QbMtcBKlHbzgsYWiQWjEfJILeVHsC7qWnq/v7LLGugdq4uvmboZQLVyez1
         +niI9zPoRYlod2J+ldwI4ineZkoKf2f4m5xr0Z5Izm7afChDkLf3NHKoLlq2R2iuFXPm
         arGLNHiO9hkw2xcwlY3DEt9942gyeJyD1d++JjWCFnQtoy5gGmDMUEsf+bhl42HZSEQk
         ru4S4UfAiLX+Bp0puhNEF0y3o+QaroFt6jxBv3FUMb/r8iz/orBcM2VU9ghL/1ieE9yI
         gvbkJd2nP1dp0E0RM6wR1znaeIiUatuDL3pHFnQjtm1+IRU8MGgvYB7Phqtbdf+n3Av5
         aVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698326487; x=1698931287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xcSEt7nTMuwkE+QgbNFoQD0oV4mmJrUn9Xh1xHLwJk=;
        b=pnam0yC+o3QtdlqeVUcPq1m3cMZNCiqTPilJVpjvlBxty//PDbyw86haatADW/wOVr
         e34nuW5kvYx2FK30aauZNdsPa69Bnpw2y6DWSCdyPVmbFnIvfAnig5IvsTEtGylXoGaj
         aOvDV2NxM9Tm91xMU4DzYbCeFILnmjk/ZNWOq2+80T/tC/vGEYVULBC7xKaYKsxwDxfw
         SBxbYTUPC4QT6f6Z3AdI0A55HJxti+yEwxu4hBYqpXJJKHyFAM0DB+nOk1n78EosLShC
         fM7jZPDJuk3KBcIeZPZS4CxA/Xi0jGa4rYVF54T75o4ExvbLDEjxby6k0szQc6v3BiuR
         WT0A==
X-Gm-Message-State: AOJu0YztEkvknKov6efLZCnYpzwCFW5VrcDvllkJ7useCl/T3BWvJzGh
	SXoGP7/Vx9WfsC9Pg95w+tF8pQ==
X-Google-Smtp-Source: AGHT+IFYCy8h45EdUY8kJ9ndNVZ61NzkfOh6KhL3Mf9bJkxJaMSGtXL1ndYrNeEmJxrS4GklNkEWew==
X-Received: by 2002:a17:907:3f08:b0:9bd:a5a9:34de with SMTP id hq8-20020a1709073f0800b009bda5a934demr3012154ejc.23.1698326486637;
        Thu, 26 Oct 2023 06:21:26 -0700 (PDT)
Received: from localhost (mail.hotelolsanka.cz. [194.213.219.10])
        by smtp.gmail.com with ESMTPSA id lv12-20020a170906bc8c00b009c657110cf2sm11675418ejb.99.2023.10.26.06.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:21:25 -0700 (PDT)
Date: Thu, 26 Oct 2023 15:21:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
	ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
	kuba@kernel.org, andrew@lunn.ch, toke@kernel.org, toke@redhat.com,
	sdf@google.com, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 1/2] netkit: remove explicit active/peer ptr
 initialization
Message-ID: <ZTpn1Y0bGgOp6eUz@nanopsycho>
References: <20231026094106.1505892-1-razor@blackwall.org>
 <20231026094106.1505892-2-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026094106.1505892-2-razor@blackwall.org>

Thu, Oct 26, 2023 at 11:41:05AM CEST, razor@blackwall.org wrote:
>Remove the explicit NULLing of active/peer pointers and rely on the
>implicit one done at net device allocation.
>
>Suggested-by: Jiri Pirko <jiri@resnulli.us>
>Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

