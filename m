Return-Path: <netdev+bounces-48410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74507EE3FE
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C4B1C208C4
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E534555;
	Thu, 16 Nov 2023 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNF8+aBH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FCF18D
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 07:14:32 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso1376944a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 07:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700147671; x=1700752471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zchWcd1VetQFlDRCGcO3MnXKCURIM84DnJ28E7Wray0=;
        b=CNF8+aBHx+/kRmT1EeKqyISILJJ9LJS6pirWZtACqC2rJtZY1CWzd2PyW2NOPMuXcw
         0KMoihGGqgbgIx53fj3RhQIiKlL6xEQMFyQwmbCMAlUVMkVoG45wqoL5FsG50Sk/8Lyp
         AoAQbVmqdaJXjzhQu70nB8g6UaM1i8flKqoFVegN+yhdib8PhQdAH81lLMFt+BdL+Qlx
         wtYP3wJsxFVw1FyE+z/N6f2lgR1X2kl52waQFOdm/CLDOB0pVRLpEos0I1bHVsYRqC5k
         N+uQdLlx8/Ss7k1QmF4LEU5AOqVx5zwZcQNAQvD/BbyVjPjIWcth3Qr7RM98xRo/2+Km
         aV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700147671; x=1700752471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zchWcd1VetQFlDRCGcO3MnXKCURIM84DnJ28E7Wray0=;
        b=QSTA2FuEL2yNPHF5Cfvrx4nnLqwm4T+49h2Q+jhF26ljFSuOiCeKNFcxWbH5ae6yPC
         kzjeONQi3Xoj4Ktsa8AqWnKU0hpa3IcNlLUUAkvPZq48FlnfRuTRgea3HvSuN0129f/m
         nliInfuWGOUSkESh7T4DdlfT32nHAlvrsm/FP4FdY1vCeVg2n8HKeuRBWkWwjz9P+ZTO
         FLp64BXnrxtud2N51UTEyo9+1XGWMES15ywjY2t/R4B1WeqdbXa77lqsMLaUcfyl4K3+
         yvX1cLt0aJwWgU8Wxm4nJSR/o9AW+THh5L7OYSibRhg+IyiiKV8PD3wfs82QuQcepA1E
         L/fw==
X-Gm-Message-State: AOJu0Yx1VwvBodOxLPsNSrmw9t+f0qEgwaPrVPzT5LxgnsyMZqMaYtRz
	JFoz1Q3ralnKmbRFvsHh0uvCo+yx9p2W/alXX/Ps4xc=
X-Google-Smtp-Source: AGHT+IFAGGq1m+5fhjcl4MekPgKa3neNani6ipg2hXcCjqEDn2aDCpO4BD5jWCLDvSQb0F3g9b95orjBOpPaYR9wdEs=
X-Received: by 2002:a17:906:3452:b0:9ae:7870:1539 with SMTP id
 d18-20020a170906345200b009ae78701539mr12801874ejb.76.1700147670793; Thu, 16
 Nov 2023 07:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113035219.920136-1-chopps@chopps.org> <ZVHNI7NaK/KtABIL@gauss3.secunet.de>
In-Reply-To: <ZVHNI7NaK/KtABIL@gauss3.secunet.de>
From: Andrew Cagney <andrew.cagney@gmail.com>
Date: Thu, 16 Nov 2023 10:14:18 -0500
Message-ID: <CAJeAr6t_k32cqnzxqeuF8Kca6Q4w1FrDbKYABptKGz+HYAkyCw@mail.gmail.com>
Subject: Re: [devel-ipsec] [RFC ipsec-next v2 0/8] Add IP-TFS mode to xfrm
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, netdev@vger.kernel.org, 
	Christian Hopps <chopps@labn.net>
Content-Type: text/plain; charset="UTF-8"

> I did a multiple days peer review with Chris on this pachset. So my
> concerns are already addressed.
>
> Further reviews are welcome! This is a bigger change and it would
> be nice if more people could look at it.

I have a usability question.  What name should appear when a user
interacts with and sees log messages from this feature?
    ip-tfs, IP-TFS, IP_TFS
or:
   iptfs, IPTFS, ...

