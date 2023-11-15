Return-Path: <netdev+bounces-47867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082167EBA9E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 01:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5429281389
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 00:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10D19D;
	Wed, 15 Nov 2023 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="aRjZQ1DH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BD375
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 00:36:21 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B69EE4
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 16:36:20 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6be0277c05bso5669319b3a.0
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 16:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700008580; x=1700613380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjX6z+JwxYqT8aozp/Yx+gDJ3sCgyfJoEdhMLf6jqcM=;
        b=aRjZQ1DHDTcgEH8/6HUs6J5JxqM6E/hb4Zaj5lZrDn0wUCOw0sB/6HFh2CszeZpGfN
         S0mzegBndYRgo2kQQLlscvh+3UwiUDixMXVCfFCUTbUdzPaZFrbzBy2Gi4c/CaNRpz6V
         yt36y6eRXn+ZQpxkfla4DU8Vw826FIgW/+9529ZzQ1sVa1RxqXYQQLsJlHusxsq/MCvN
         BjJoADExEs8FAZxHxTOYAiPMxRZSfzskoE7uokb/VKF6Z0JdSGU0x7AAE2pbUAnde0Ar
         cS9fNV7SmKlo+f0zhzbOWBWZMz2fAojCtlIzmvFjAl26VbDsjnvm2GYg6HJbPQf6eR5o
         btnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700008580; x=1700613380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjX6z+JwxYqT8aozp/Yx+gDJ3sCgyfJoEdhMLf6jqcM=;
        b=i87U59x3XEG0CwpnFLjrjnu0+AwZvqjbeGYiOLBjd5YGibCTddo7yBAAK2eat4OBj8
         OOcYicPCTJlH7JCyh0C/OS7BfSqJ7pQuNzy79h11PsQNEhEEy32HU8cD/9mfAyCUSehh
         vzY1FANQ6VTbGhEuizxdP8+d0GeeRMAKj+4FW1RU91Z7IhDxl9dGjveJ9orTWKJOepfO
         LOREppjKBhMh5ZxIWyH7mZGPfS+vzUQtWq1q+kWXJ7BreXZHcIDMvovGGGyJ0rBIQpVw
         dnmgkOU4VHPBX+uECW9AJkdvQdTOx0WMSl00baYje1Mq8n8lPC7OX9+2KUEMVMsT7Jc8
         AdpA==
X-Gm-Message-State: AOJu0YwfRNnkTEA6mX6n84hZtQVN6Jcc6dOyTLGhdlJ64aloLfi8g7cq
	y+YSFrgykauuVFJF8unZCZ6R3u+DiyvaQhXRaSg=
X-Google-Smtp-Source: AGHT+IHpimjOwXmYGxVVtcINwAYlf+s//h7vSseocTkYEDUL62KButEnbSJWy5aFaP/kZbd2djASDg==
X-Received: by 2002:a05:6a20:4404:b0:181:10ee:20c6 with SMTP id ce4-20020a056a20440400b0018110ee20c6mr11602047pzb.42.1700008579897;
        Tue, 14 Nov 2023 16:36:19 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902778900b001ccb81e851bsm6207148pll.103.2023.11.14.16.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 16:36:19 -0800 (PST)
Date: Tue, 14 Nov 2023 16:36:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: heminhong <heminhong@kylinos.cn>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] iproute2: prevent memory leak
Message-ID: <20231114163617.25a7990f@hermes.local>
In-Reply-To: <20231114092410.43635-1-heminhong@kylinos.cn>
References: <20231114092410.43635-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 17:24:10 +0800
heminhong <heminhong@kylinos.cn> wrote:

> +			if (NULL != answer)
> +			{
> +				free(answer);
> +			}

Four style problems here:
	1. Don't use Windows convention of NULL first
	2. Don't use Windows style bracket indentation
	3. Brackets are not used in kernel style for single statment if()
	4. Since free of NULL is a perfectly valid nop. Just call free() and skip the if.

If you read the existing code, you would see that it uses kernel style.
Any change should follow the conventions of existing code.



