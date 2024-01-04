Return-Path: <netdev+bounces-61560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA1824434
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4C328350B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87563224C6;
	Thu,  4 Jan 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLxOiDGz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAB2232C
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-427e59202ceso3152681cf.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704380084; x=1704984884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q32425e1xpwsnJuazshbVOA6xh6sJTNlsWqeXOlt/n8=;
        b=PLxOiDGzuwtCRFsSMdJtcX5FlA6QCUAI/e8YV3KgdgsLRDp1E9K8kAWGYBjQZqI8Cd
         CHzgSojbnT2Zi+MJ8DITdPh6KQnTV+rhESOv+EBSMPNij9Z19WrOBH/E4fvfxevrLPwQ
         oqaRKL1qpSrw0Y+aU06lF45lzJ1AocoLJtGjaBoLpPlYDFBVKMkgAUTRm/YhRmFg+1r1
         S4zHD/Ix7Te4KDsDVesGuKWd2DQ+43CIMkZHjZOHo2HgqeEWgMOybrvzebtNqKNCGBz1
         7uSvLILMJ3HBGoAfGl/IPEhvZEmeZqz2lgQalmHtAKRzkN3MCrvHdpynAPvlCALLirei
         TINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704380084; x=1704984884;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q32425e1xpwsnJuazshbVOA6xh6sJTNlsWqeXOlt/n8=;
        b=IbyM+qTIszyXz4We/tK+OFiOyAogy6OuG5UNcwgFwF/f0pKsfN3Q/3tDM9d/9z0lf1
         bEOXeJ6iftswV79GLSO0/cW3MnlZafF3/TEeJw9F2SxtqvirG7LDBovyQ93RGMLAEUJj
         l2lEc2ziVfCvXwnppMN8ITcK7D3BB6F21vOB/JfQ0uV/cXYcb91Cgv2OINjwyLm3IS6C
         2qfk6Pr0uIQ4jUk4PQKceHXuLnlnhwbK6osRHUaYjBU47YIocl+yjeIHpmxYrqGAuady
         IxezZA7bbCAX4roR+5hxYGGfUswdVKflp702Mj4NN8jSbFhurV8KcwWZMtc1geUCC+6p
         xMKA==
X-Gm-Message-State: AOJu0Yxlgrc8KFbkJw8YmenHF3dhqK4Cv4pm2DUgx5qxqUM3Q1MKjDwT
	/DwMI58a9fAE03NC2DA3xKM=
X-Google-Smtp-Source: AGHT+IHRqewxSDoue7L6Zttw4zBKwAUuhbXjwHE4a8pyVbof05ZEMs5sWu7xav5BglxeWfn5z1y6Ug==
X-Received: by 2002:ad4:5dc8:0:b0:67f:666b:ada2 with SMTP id m8-20020ad45dc8000000b0067f666bada2mr660772qvh.28.1704380083952;
        Thu, 04 Jan 2024 06:54:43 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id z24-20020ae9c118000000b0077f95644dc3sm10959283qki.57.2024.01.04.06.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:54:43 -0800 (PST)
Date: Thu, 04 Jan 2024 09:54:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 willemdebruijn.kernel@gmail.com
Message-ID: <6596c6b354b82_4bb9129481@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240104144119.1319055-1-kuba@kernel.org>
References: <20240104144119.1319055-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] net: fill in MODULE_DESCRIPTION() for AF_PACKET
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add description to net/packet/af_packet.c
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Willem de Bruijn <willemb@google.com>

