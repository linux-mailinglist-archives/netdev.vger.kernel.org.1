Return-Path: <netdev+bounces-14880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDCB7443CA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 23:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE501C20C27
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB211774A;
	Fri, 30 Jun 2023 21:17:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8CA16428
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 21:17:09 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF82680
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 14:17:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b7ef3e74edso13749365ad.0
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1688159825; x=1690751825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds9taSlUUpDtIiXYw5zPyOaofQ/jvqQJgEiEmWkm7Zs=;
        b=CzBa1vX+l7c0bjR2uBTyxGP9gf27VSesET98uqFJY7BueVVWvqN9jRTpmUdQyge0NJ
         TYcTgm7FVOYYz5h/wQ+mdCAiMlVNo/AJNsXdBQXsOMWx0QcnGhDWK2CR9bVzgGfP9tS8
         xcF8vyPGHs5yUL5rpcTpjKs07QGRA3ScAsCOH7meGawoZQeJJhB1yLcr11jKTh0cKFAf
         tcnF+jn6CEa0KG4WzTmOSuhO5j52lRLZ3xulXK+p51Ho2Te02yPdORTYsdxOV5dWWnX9
         amCC42dGkUQV7Ew3RIsLsdYn3B4Z+Ne2jwhSumhCSQ9bGYLUWyhHKslgQfXCEj6ayja1
         OlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688159825; x=1690751825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds9taSlUUpDtIiXYw5zPyOaofQ/jvqQJgEiEmWkm7Zs=;
        b=LTb0CupU4Lj/FiEpmLJqIixpX+Ble00Cv4pK72BmWOvB/bCeJA0byIyGYqBSS06gbq
         cTSKvJu3V+lr2/HpNXjAeJQe4YJBXTQu+4TCPJnnlobOPRgeSPYcjoQONPx4+5y1gB+k
         +a3fphCgOnS3zYlZo1L+ImljYa2z9P6WDsmVFhowk4PZfFs3PGfdkyyRvh/kgKEeS9GO
         qNRv6CRE98Ddj7gwhBnL3vPyLwy/yosMV0uiEuycNGbWoiQTQYVO1NtVwlE0l3uEBYy7
         pA4Hsn8vK+yK496/2Pyqs4zy+WogdpYHsB4PqR4Gs4zTJvpQhG16TQVFsVEZORpD1GI0
         E50g==
X-Gm-Message-State: ABy/qLbrAeziq4S/OgNiOlpCaRXtjIq/mCu9UnuNun7YMXG8SZaD0gyI
	2YiTNNuh3Zti549N6VnNzxrMVw==
X-Google-Smtp-Source: APBJJlF9mOVwA/g+fvMZiqbfQxCMJuSpDCBmSJPEEILvUKJC5EbTtde29xRIoWmg5sgNAIAMdf5AnA==
X-Received: by 2002:a17:902:e74b:b0:1b8:50c9:af72 with SMTP id p11-20020a170902e74b00b001b850c9af72mr3401859plf.54.1688159825202;
        Fri, 30 Jun 2023 14:17:05 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id bj8-20020a170902850800b001b7fa81b145sm9488949plb.265.2023.06.30.14.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 14:17:04 -0700 (PDT)
Date: Fri, 30 Jun 2023 14:17:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, hmehrtens@maxlinear.com,
 aleksander.lobakin@intel.com, simon.horman@corigine.com, idosch@idosch.org,
 Zahari Doychev <zdoychev@maxlinear.com>
Subject: Re: [PATCH iproute2-next] f_flower: simplify cfm dump function
Message-ID: <20230630141703.60e5074a@hermes.local>
In-Reply-To: <20230629195736.675018-1-zahari.doychev@linux.com>
References: <20230629195736.675018-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 29 Jun 2023 21:57:36 +0200
Zahari Doychev <zahari.doychev@linux.com> wrote:

> From: Zahari Doychev <zdoychev@maxlinear.com>
> 
> The standard print function can be used to print the cfm attributes in
> both standard and json use cases. In this way no string buffer is needed
> which simplifies the code.
> 
> Signed-off-by: Zahari Doychev <zdoychev@maxlinear.com>

Since this does not depend on new kernel features, will pick it up as part of
regular iproute2

