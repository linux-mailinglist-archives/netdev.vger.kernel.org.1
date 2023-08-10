Return-Path: <netdev+bounces-26405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908B4777B79
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DE82821E1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394D200B5;
	Thu, 10 Aug 2023 15:00:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDC1E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:00:37 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8270526B6
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:00:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55fcc15e109so641061a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1691679636; x=1692284436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/arWWfmyrsjrLBTqVG4GLgVzQSQxMO7wr/9WW4IOLeQ=;
        b=BQH9xVCJn/Ub/xa6dbzN9R7lyA5EQeNZ+3kyH0GI5roEVMqaMe9eP9pTEy1/5XWW6H
         x5Jeq8wCpG8fuVBjheBbs0+4um4Uz2LKzgO3KCY1SCBhuNbkyOjbVVE32Gz1MnhLiN8R
         1a3ESzQ2aJxqLff583Xq4TJHjbGd1IcL9liyme5+vzRfE2RB0l+pATdY5o3//PkVKfoi
         vrsP936B8n5YfnGrvAyyUP0UYfuYEd5ozy457/jJQVSe9ZBR9iY1ebo/vOiBVtcHsgEj
         2cK00Y8/61cppe8HsIWAq7UlwuU0JVheCt28E1uZDMqgMM3eJkDwAzs8sYV8jQhf9ign
         T2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691679636; x=1692284436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/arWWfmyrsjrLBTqVG4GLgVzQSQxMO7wr/9WW4IOLeQ=;
        b=MMLvxAAzWpzkIriK3ejUvjVcirji2A1LrE3xLTi/363pj87WA3d0YcgtwKzXTyY8lL
         n/n5ZPYn8HKuHgkU+OQ2cys3MaWjipjadbB+DpkbtvZTyMhcSiwkjPemD54SbB96l0pV
         0nGHiHCk/8CsTYrmJNls7Mm15+j5tcMTyAbu3iDtXxOVjx7jsf4f8UEGhKbqhxN+7q1T
         87EZELCX9atzQx6cHY9siDHTEQh59+mmyCvxhiXO1g887UUffWkHIq0vX3ihBJ5w/Ya4
         A8IAg6lMXRH6MwAOTTdTL8oBQ0nNQQUIXDmtA4aLGRoaDDn7weUILy7XOy8PLqY/9d0Z
         +Hog==
X-Gm-Message-State: AOJu0YxrYGpvYDGrQpAJMDGbuFv6Mxt3TjbqSvD1N9pycV6g3p9pxPDs
	s8rsVd95znv5w7P/K1pXbDdLKfu8YmIOLnIQSNUjhg==
X-Google-Smtp-Source: AGHT+IFU4y0TMBdP/jJVSdKQ2NvXLzXXwTm1Ol8ZHFNrnd5g5cBjC0j57k7LYbnOk+IebgMiRtm4Ag==
X-Received: by 2002:a17:90a:9ed:b0:263:5c6a:1956 with SMTP id 100-20020a17090a09ed00b002635c6a1956mr2052238pjo.25.1691679635932;
        Thu, 10 Aug 2023 08:00:35 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b00263e1db8460sm3521451pjb.9.2023.08.10.08.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 08:00:35 -0700 (PDT)
Date: Thu, 10 Aug 2023 08:00:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: Nicolas Escande <nico.escande@gmail.com>, netdev@vger.kernel.org
Subject: Re: [iproute2,v2] man: bridge: update bridge link show
Message-ID: <20230810080033.08853c15@hermes.local>
In-Reply-To: <ZNIowqAsMJhhUtoq@shredder>
References: <20230804164952.2649270-1-nico.escande@gmail.com>
	<ZNIowqAsMJhhUtoq@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 8 Aug 2023 14:36:34 +0300
Ido Schimmel <idosch@idosch.org> wrote:

> On Fri, Aug 04, 2023 at 06:49:52PM +0200, Nicolas Escande wrote:
> > Add missing man page documentation for bridge link show features added in
> > 13a5d8fcb41b (bridge: link: allow filtering on bridge name) and
> > 64108901b737 (bridge: Add support for setting bridge port attributes)  
> 
> FYI, the convention is to refer to a commit in the following format:
> 
> 13a5d8fcb41b ("bridge: link: allow filtering on bridge name")
> 

If you use checkpatch it will tell you that correct format is:
commit 13a5d8fcb41b ("bridge: link: allow filtering on bridge name")

Fixed it during merge

