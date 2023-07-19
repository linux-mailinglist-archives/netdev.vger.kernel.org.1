Return-Path: <netdev+bounces-19259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFACF75A0A5
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D913280FDF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F5522F13;
	Wed, 19 Jul 2023 21:36:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDB22F0B
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:36:32 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C3113E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:36:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666ecb21f86so63652b3a.3
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689802590; x=1690407390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoPpG3cEaFtAlZLyspa+80JPrUAXwvNWUyBMTOrPeR8=;
        b=yGbX74dPPwGv6SebPnioPYSTHq13uYlw2Lurs68UTkHJrME2zpHM7LNx4nk8BRguAf
         ByArUS2xn9UnNYACQ8BGnLdumMof414OsegjIf046fyk8xYcDRs7lBJCtvX/wCPFZFhv
         eFFyvX26ahGtqmwq4JkK2I6LPzAOVWSQl3PSQc26LYsT1VbQwIF1xWEx08aAVbpLr6Hc
         P/j1+LofVzXoG89kmkCTm9o/jc6DcDd4g7hcC1oJzD0DYh+RmvDv2xt628UUEKYBzvAP
         dYh9fiPFFZm1mXl+euP0vCvdBfetFp9tXNktOM9YhM680m7ruucQjO6xt318Gd3NtrJU
         Cauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802590; x=1690407390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoPpG3cEaFtAlZLyspa+80JPrUAXwvNWUyBMTOrPeR8=;
        b=hZK4vjsxJWMntyH9QAPqIVci/aLSBByxjI/y7QqZjiRai2Xv5BRnrccLiT5eP6ppGt
         P1DkxNmJfa7uMyj0VwccgV038A61TE4FfSAsjugTUDYvTmVz+NA5NsIbN5+wA0Pavu5T
         RRgFThdKQdxVk+M/OD0NXdPkOvEY1H04ZHmLkXVmFbut0nwyg90+b2RBcPiJ81kymar7
         Zy4ecbLiQk+PQk3fhHOtGyrcIq0J0hC/Dx6Hnc/23LqAVxi3BjC6O9HbroAX1wobWPj7
         zc70RhurVA/C4O0GsOcKyb0C5Y62BT4m8s5qKDKVbBff2lTeeIgBeDqM4YZQcUH5H3jd
         aU1w==
X-Gm-Message-State: ABy/qLZ+WAAzrXIM6G5b8cNAwSCSMC8mKz0EImklIzDpac20jptOUbYi
	peZXQdL1zAGPkmd4pfalzZVuhG/FXH/71JbBCTRIB5c4
X-Google-Smtp-Source: APBJJlGHn3lR68sjisSRZah/AYswIVwWGebCQnLzQB3/k5lcr7wT+St2lkMTX7kSv+qrhmzvV1OKSA==
X-Received: by 2002:a05:6a20:1399:b0:12b:fe14:907e with SMTP id hn25-20020a056a20139900b0012bfe14907emr630184pzc.20.1689802590393;
        Wed, 19 Jul 2023 14:36:30 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a00270300b0065a1b05193asm3682488pfv.185.2023.07.19.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:36:30 -0700 (PDT)
Date: Wed, 19 Jul 2023 14:36:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gioele Barabucci <gioele@svario.it>
Cc: netdev@vger.kernel.org
Subject: Re: [iproute2 00/22] Support for stateless configuration (read from
 /etc and /usr)
Message-ID: <20230719143628.4ca42c3f@hermes.local>
In-Reply-To: <20230719185106.17614-1-gioele@svario.it>
References: <20230719185106.17614-1-gioele@svario.it>
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

On Wed, 19 Jul 2023 20:50:44 +0200
Gioele Barabucci <gioele@svario.it> wrote:

> Dear iproute2 maintainers,
> 
> this patch series adds support for the so called "stateless" configuration
> pattern, i.e. reading the default configuration from /usr while allowing
> overriding it in /etc, giving system administrators a way to define local
> configuration without changing any distro-provided files.
> 
> In practice this means that each configuration file FOO is loaded
> from /usr/lib/iproute2/FOO unless /etc/iproute2/FOO exists.

I don't understand the motivation for the change.
Is /etc going away in some future version of systemd?

Perhaps just using an an environment variable instead of hard coding
/etc/iproute2 directory.

I do like the conslidation of the initialize_dir code though.

