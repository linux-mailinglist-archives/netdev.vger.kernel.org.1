Return-Path: <netdev+bounces-21128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0437628AA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242A5281B42
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3868111F;
	Wed, 26 Jul 2023 02:18:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56367C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:18:57 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF71BD6
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:18:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6686a05bc66so4017822b3a.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690337936; x=1690942736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kKNdrkdfyEFstR1y5xEZ+Oaic/KHimE93Cnl6163A0=;
        b=AavjTf6gNnnFGvsqSxpmq+LXMyxh6sGf1VTG/sZRgivd+Ig2qrfzkFRDPRM5ezhJGS
         apnYMoxTv6Uan5jt4/QcbKZuDc4/GUtT3PUVvfCHAbHrXgaicM1kvCBwv7OwRKa5kg4J
         N4XBsLoNboaUvn1DmYTh5fTC9TGi85Bl3n8z52orZNZZlTyme49NrJ+3KUYitEcdrKGd
         7uXgVjDPHlbv3iLaZA7Dc1xGjxY2kFW2LYq6SiF7gHvqOKcZMSFBEib+SOc4E4yT7qeZ
         J0kBcOkZJFfT1L/GGoUzRUQ5/iamGxTPla7BkND/BY9hzfQOBPwBMZGfQiqQjJHD2/4C
         Jo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690337936; x=1690942736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kKNdrkdfyEFstR1y5xEZ+Oaic/KHimE93Cnl6163A0=;
        b=lvVIYkheOZ0QkSM3m4jiIv1tjSBENrR2Q5l53cOuGvC75H4ZkiyqNIXUF24NPrQCgC
         Z6yqzP6enSOuWj7gp7XVHn+gbrihbsGOvA7Y5GLnwwiuXhF0BRdQMGtFYaEGyZSPMKhC
         NP1YPcATuvnVi0n8S/tkFPA77oc+EBbYwVD3EjXQeVaEHW3wGEORUJ8uvMgTeT8oQ2Zs
         3lwcdlBx5t3y1s0ovuxasTk7lgPxfnY7Z3rFNEv+3A6BIdz0IjOcn3389nUmOec7a4xk
         gOicOORKZpQlN8h7wRp2eSavh27cDfWzHTxO1RIQu+EfwNbyZ16h352FlaT6vFBRqJDr
         Qzxg==
X-Gm-Message-State: ABy/qLbgf9ZdQLEgUAjHyfzuFIzaVbFsvsKGgO2D1vR4nEi5R2KCaJzk
	qTvAGmBZmtF162btowqS+ejmInpPmDFFr1uQrRqJyw==
X-Google-Smtp-Source: APBJJlFDGnAxDcGaGey/mluYwzQ9syOX61wDuKA7yRoyT9Z/c0Tq6VAmKQpkMdy/BrYdmoP2w64OhA==
X-Received: by 2002:a05:6a20:12c5:b0:126:42ce:bd41 with SMTP id v5-20020a056a2012c500b0012642cebd41mr774056pzg.47.1690337936054;
        Tue, 25 Jul 2023 19:18:56 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902748200b001bb98de2507sm5975865pll.213.2023.07.25.19.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:18:55 -0700 (PDT)
Date: Tue, 25 Jul 2023 19:18:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gioele Barabucci <gioele@svario.it>
Cc: netdev@vger.kernel.org
Subject: Re: [iproute2 v3] Read configuration files from /etc and /usr
Message-ID: <20230725191854.75b40337@hermes.local>
In-Reply-To: <20230725142759.169725-1-gioele@svario.it>
References: <20230725142759.169725-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 25 Jul 2023 16:27:59 +0200
Gioele Barabucci <gioele@svario.it> wrote:

> +	/* load /usr/lib/iproute2/foo.d/X conf files, unless /etc/iproute2/foo.d/X exists */
> +	d = opendir(dirpath_usr);
> +	while (d && (de = readdir(d)) != NULL) {
> +		char path[PATH_MAX];
> +		size_t len;
> +		struct stat sb;
> +
> +		if (*de->d_name == '.')
> +			continue;
> +
> +		/* only consider filenames ending in '.conf' */
> +		len = strlen(de->d_name);
> +		if (len <= 5)
> +			continue;
> +		if (strcmp(de->d_name + len - 5, ".conf"))
> +			continue;
> +
> +		/* only consider filenames not present in /etc */
> +		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
> +		if (lstat(path, &sb) == 0)
> +			continue;
> +
> +		/* load the conf file in /usr */
> +		snprintf(path, sizeof(path), "%s/%s", dirpath_usr, de->d_name);
> +		if (is_tab)
> +			rtnl_tab_initialize(path, (char**)tabhash, size);
> +		else
> +			rtnl_hash_initialize(path, (struct rtnl_hash_entry**)tabhash, size);
> +	}
> +	if (d)
> +		closedir(d);
> +
> +	/* load /etc/iproute2/foo.d/X conf files */
> +	d = opendir(dirpath_etc);
> +	while (d && (de = readdir(d)) != NULL) {
> +		char path[PATH_MAX];
> +		size_t len;
> +
> +		if (*de->d_name == '.')
> +			continue;
> +
> +		/* only consider filenames ending in '.conf' */
> +		len = strlen(de->d_name);
> +		if (len <= 5)
> +			continue;
> +		if (strcmp(de->d_name + len - 5, ".conf"))
> +			continue;
> +
> +		/* load the conf file in /etc */
> +		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
> +		if (is_tab)
> +			rtnl_tab_initialize(path, (char**)tabhash, size);
> +		else
> +			rtnl_hash_initialize(path, (struct rtnl_hash_entry**)tabhash, size);
> +	}
> +	if (d)
> +		closedir(d);

Why is code copy/pasted here instead of making a function?
Seems sloppy to me.

