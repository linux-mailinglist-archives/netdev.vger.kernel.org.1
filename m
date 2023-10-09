Return-Path: <netdev+bounces-39276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240FA7BEA29
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548351C20B7E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9E33B297;
	Mon,  9 Oct 2023 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJNfrGWs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D038DF8;
	Mon,  9 Oct 2023 18:54:14 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9189C;
	Mon,  9 Oct 2023 11:54:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3248ac76acbso4416270f8f.1;
        Mon, 09 Oct 2023 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696877651; x=1697482451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFPc0uDXo5Wb2b6XuvLtE8BhMkgpBeAovPcZyNFbQqI=;
        b=NJNfrGWsv921V/KjW1Nq6ALfuNk3BMQiZ6pmYDNNZYatc0i1mKiAkvo5dGWyx+DMun
         64DcLPc1EE/Jo4nYtsu0KmabIdkdWpONDgfZ2N/aFl49AC6ZR1tllu10KIvxa18ICNJP
         BvwFHq2txa3KFWr9U6Bq2U2YZCCDpW5SNMSxVy8ILsO9JKEbTvh6uLKRobUQUr+s+KGy
         4pUO9FLwXmw5cZM5NbwnWsKpN83Eb1Nx520Yfz677IAXE8RNf2RW7fwBjgujKxNZtuK/
         n9z032oKz4ffiwOgovJctb7XvHyGdMdtwCYdfECbMk2sV6EqLFNCzf9sVXuB9qyIGPE5
         eq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877651; x=1697482451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFPc0uDXo5Wb2b6XuvLtE8BhMkgpBeAovPcZyNFbQqI=;
        b=fJwG8uTCPdbdLvhe7552ALLPqYFtKy5y1FdTNsbuU9eJuoAVVdEIozEByUmx8pHwaf
         Y2qvoDjergEl1dHYt4DptgpfunWZ9JcmBEor7qwSLhUcr1dUFG15esbd/516jniKNpcP
         FqwBEU6e7ALzbQGHMMNO6poksdx+OGzMGzv6SOKHtdNscYbV/ihRIWqGYaRXmD6AaSxa
         FAqch6y2BxSlt8mzmHY2QQvte6XsW9KRBYQ6U7kffjhCiH/LWo0Nh3o2yDLMNpGkb2MQ
         n1qVgY7banNneXJtZgOp81FQpQ74Jm59FGwPi5VphAmCqvMQ0rE/6jngOULuZ3XHXO0+
         ew9A==
X-Gm-Message-State: AOJu0YyKBsZVUvHgGiJ9+b1QczgGx8WA8AM9ekmbgegg/OkdgYGS661M
	xkJEcitDGgN27+zddWZDj+0=
X-Google-Smtp-Source: AGHT+IHUvUjkgwvvBP8mDLjDZze4cyt0X5T9Jyj1BK5Iqzj3ttrBpuuN+DlmHRw/gGROplZOUaGwGw==
X-Received: by 2002:a5d:4d12:0:b0:323:16c0:9531 with SMTP id z18-20020a5d4d12000000b0032316c09531mr13946871wrt.13.1696877650868;
        Mon, 09 Oct 2023 11:54:10 -0700 (PDT)
Received: from babbage ([2001:818:e906:400:b2bc:40c:b83d:9c16])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d4a8e000000b003197b85bad2sm10439348wrq.79.2023.10.09.11.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:54:10 -0700 (PDT)
Date: Mon, 9 Oct 2023 19:53:30 +0100
From: Ricardo Lopes <ricardoapl.dev@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
	justinstitt@google.com, linux-hardening@vger.kernel.org,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: qlge: Replace strncpy with strscpy
Message-ID: <ZSRMKoL1ljRM01Hq@babbage>
References: <20231006161240.28048-1-ricardoapl.dev@gmail.com>
 <202310090921.622A22FF8@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202310090921.622A22FF8@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 09:44:37AM -0700, Kees Cook wrote:
> Thanks for working on this! Doing these replacements needs analysis of
> several issues that should be described in the commit log:
> 
> - is the destination an %NUL-terminated string? (strncpy can produce
>   non-%NUL-terminated strings and sometimes this is intentional.)
> 
> - is the source %NUL-terminated? (Sometimes strncpy is used when memcpy,
>   kmemdup_nul, or other things should be used.)
> 
> - does the destination need to be %NUL padded? (strncpy does this
>   padding, but it isn't always obvious if it's needed.) When padding is
>   needed, strscpy_pad() should be used.

Thank you for the feedback Kees, I really appreciate it

Regards,

Ricardo Lopes


