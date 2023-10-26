Return-Path: <netdev+bounces-44391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D77D7CA8
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BFF281DFB
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904F0FC07;
	Thu, 26 Oct 2023 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LLmODrHF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7212FC134
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:05:13 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4190115
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:05:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99de884ad25so75950066b.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698300309; x=1698905109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8o6FZwDyH3jeQW903fHenTgcV9DcNTZdcoqxi/6X87I=;
        b=LLmODrHFoIeN14rzP/tkRIUCva33EgIe458pnXzKzduR3TmN9l+Jlne+qnHMXmyMfw
         MkqOwUqjbDBefK5mUCJnq1eImG+XQC98LsYweO7+qxULaRFZ4WhqV9VWR97gfJMShn2A
         +nR3Az1abi82lq0aE9FBq/V+8iYo8qTdkFXo6AFYV3VpO1Vhpqlq3SLKFQWnhg+8tHWh
         qrkZVx3Rc+jBVjuAFlEORumcLHLWyUinJJpLa2ISAEkuKhBmA+es9o3w6zvUy2+bbu0y
         mIlc42ZoVNaWndbhOVB85yBbzq2AXPN5cOlZj8+ivljH3NNIMPaGzBC8x9kKUGJzxxRm
         DWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698300309; x=1698905109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o6FZwDyH3jeQW903fHenTgcV9DcNTZdcoqxi/6X87I=;
        b=YkrChxdPoL/Xw4ZL8x/INqV8d+1gy9LngbJXLwuTjRdYYGHjge2UNubCXDO9T7hXxZ
         6RafRFdH6aXoXE2gYoQyJILtM+xv5FsdiXQjW5Oh/44CgHtSZbi9mOp9kWM5GxnJ7FiW
         U2faBQ7TxxlVUjYDYyMLFmaRzVrdWT0azrZf6VPCmAoypJ/KkgTmI6P5t4zr/3ogUSrh
         uChqnNiDRYo2vNZYyZ2NF7OG6p2GOpW8ZfO+dWrQf6B1T9VSnwGfHTblSMhijE+zPHra
         vNXrMZC20cwyvfqngLOg4eeAIWuB8Q0FFGd5pEDCzd8zZ0xqxtF65jRsTqToP6ooLhni
         GhxA==
X-Gm-Message-State: AOJu0YyEVUx7N6MXHQQ4fVu5jqSz5kSbO+6wInYj4g9qFc/UWl6hyMhp
	GcbaEtwxI0mlKi1BjBvN+T4oSA==
X-Google-Smtp-Source: AGHT+IHBRtKLtu/6dS5ngIiDSTBekn4owPO0ksXQ7vM3HyIFqs+i/iNdlZqfq5DYaiXdD1oNyU6vjg==
X-Received: by 2002:a17:907:2587:b0:9cd:26e9:a8ae with SMTP id ad7-20020a170907258700b009cd26e9a8aemr2631416ejc.42.1698300309369;
        Wed, 25 Oct 2023 23:05:09 -0700 (PDT)
Received: from localhost ([80.95.114.184])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709064a5700b009ad89697c86sm11148056ejv.144.2023.10.25.23.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 23:05:08 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:05:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] netlink: specs: support conditional operations
Message-ID: <ZToBkrWEh2Yn/Dqb@nanopsycho>
References: <20231025162253.133159-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025162253.133159-1-kuba@kernel.org>

Wed, Oct 25, 2023 at 06:22:53PM CEST, kuba@kernel.org wrote:
>Page pool code is compiled conditionally, but the operations
>are part of the shared netlink family. We can handle this
>by reporting empty list of pools or -EOPNOTSUPP / -ENOSYS
>but the cleanest way seems to be removing the ops completely
>at compilation time. That way user can see that the page
>pool ops are not present using genetlink introspection.
>Same way they'd check if the kernel is "new enough" to
>support the ops.
>
>Extend the specs with the ability to specify the config
>condition under which op (and its policies, etc.) should
>be hidden.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

