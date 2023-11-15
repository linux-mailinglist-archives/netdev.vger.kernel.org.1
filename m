Return-Path: <netdev+bounces-48093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD37EC800
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8821B20B22
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDE3433D2;
	Wed, 15 Nov 2023 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="E+0weaCF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F164C2C85A
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 15:59:24 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15A4B9
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:59:23 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso7105750b3a.3
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700063963; x=1700668763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHUTStH98CPi8Qn9gNHX+C8Dffz4kEdqV2rCwN9VAu0=;
        b=E+0weaCFNoB4229I4WQdAOFkzr4isJN+3arQir/n6cITOjGgvNq6zmEYGOedKSsdCk
         uWt/RQtpl7zPldK7q+y2UPJwju5Kth+8lrChskuoUqQ0fe4wLe+91/O/4Bs7FNvUpZeA
         y90PP4ikvjtQnLPLzNUa3nh8Vw26NxVzDCmrPSjVNH5N9tjORw9Z8a+6FPXiluC4z5pI
         spSZ0UlHEY+QUKaxA9ewgA+tNyfoao3YwwJ66d9ZRIQ93SphHVcT3/DQP6oTTH7Abq7/
         AjsCbpnGHya7qRVaWrjfIOwnhe+JolY1wQCcpVHyJoclI5dNABSMB+NqP7Guw41tteob
         D4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063963; x=1700668763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHUTStH98CPi8Qn9gNHX+C8Dffz4kEdqV2rCwN9VAu0=;
        b=t9kJHFJcOBZyhjS8fcYzZXoMs/VkqHOWo0TwCfVPQBjDO/95sHofdrdj/oYeshgteX
         kfZjEN/S5ehA8uOuBJW1ErLoRIuijgsvkmAIMtjxFTCLldelkTKGVjhhP9nOXzsp7Lkf
         v9+vye0/tQZPncaw2muVq0NC7QWgio9lEJRh1e9d0aIZWkK0VpMnhqXHFf+sLHuWHTG0
         1lqgEpmPTV7HOVJhR/840YRhiVmjZDq0ibQBKu0pIq+MSHkHCkGzr3vodndJWNhr4hiw
         rE3SsGCmteykRhFaxM6B3WON0x1gPv3krGlmI6h09+iumx/bU4vRu5HQVusxNN5Smrzy
         PCSA==
X-Gm-Message-State: AOJu0Yyc6yVhQsiwpbcNl3qt8g4ai6GECvX+eASPQ5jLF0M88GijW5xy
	Us/DEFWZ02m8FcYqriIPp5fLug==
X-Google-Smtp-Source: AGHT+IEDnTNQe8QWlw4OeizPDpqo7B4w4v1z7OW1Fg2iu7afcPbu7Xtl813sJOzp1S/lUEJwrmhNRQ==
X-Received: by 2002:a05:6a00:8e02:b0:6c3:625e:6950 with SMTP id io2-20020a056a008e0200b006c3625e6950mr15497942pfb.21.1700063963473;
        Wed, 15 Nov 2023 07:59:23 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id n4-20020a056a0007c400b006c4d47a7668sm2990958pfu.127.2023.11.15.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:59:22 -0800 (PST)
Date: Wed, 15 Nov 2023 07:59:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>, Patrisious
 Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH iproute2-next 3/3] lib: utils: Add
 parse_one_of_deprecated(), parse_on_off_deprecated()
Message-ID: <20231115075921.198fad24@hermes.local>
In-Reply-To: <8ca3747c14bacccf87408280663c0598d0dc824e.1700061513.git.petrm@nvidia.com>
References: <cover.1700061513.git.petrm@nvidia.com>
	<8ca3747c14bacccf87408280663c0598d0dc824e.1700061513.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Nov 2023 16:31:59 +0100
Petr Machata <petrm@nvidia.com> wrote:

> The functions parse_on_off() and parse_one_of() currently use matches() for
> string comparison under the hood. This has some odd consequences. In
> particular, "o" can be used as a shorthand for "off", which is not obvious,
> because "o" is the prefix of both. By sheer luck, the end result actually
> makes some sense: "on" means on, anything else means off (or errors out).
> Similar issues are in principle also possible for parse_one_of() uses,
> though currently this does not come up.

This was probably a bug, I am open to breaking shorthand usage in this case.

