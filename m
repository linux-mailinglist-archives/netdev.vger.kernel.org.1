Return-Path: <netdev+bounces-45697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 990217DF117
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4807B21057
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3717514293;
	Thu,  2 Nov 2023 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2pLWvS5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC514286
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 11:25:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1381132
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698924315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9+EloQzdVYeoamONcM2Hc+44nMTwaQEa+a85PRBSe4=;
	b=g2pLWvS5MapfDqbTmj1odZMxTZvs3UdP6lG0GOC5DKlL3Ihz+yRazSQHWZttACkXiD4QfK
	k36K0WLWGSRIl/WTluLJsAHQ9QBka7ZXiWOlNI0tnWRo3EC+jwwKiCz8c4PZBV6zYcob9d
	pjxNvCGY095mDIs2gjjcL1eOaCcgspU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-6nNqaZSCNMOJjMNQklDsag-1; Thu, 02 Nov 2023 07:25:12 -0400
X-MC-Unique: 6nNqaZSCNMOJjMNQklDsag-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-66d3f71f49cso2471256d6.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 04:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698924312; x=1699529112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G9+EloQzdVYeoamONcM2Hc+44nMTwaQEa+a85PRBSe4=;
        b=fIcaiWvyFwe3w4NJ4JQc9mO87SiJdWFAJRN2n+6NDl68u3TAbWaIVHi0e51+cfG0Kx
         hgGJJw8oeB9cG/07qeaOCJZ4Mg7vQ8hLU2nU5SfnDpDQC26/0XiAgD9WAqK2RHwUYvKb
         TWfxytC45N59ezI+BIEl4WEeicxpLhOsmxP11QZ79daGgGffvYKdKecKZGe3h7p+/Wlm
         +zxYr0jO2CwW/4MMSCTi8zBkCDwdUhKm5ysQ2VYU651gJ52JOWcYUOhtRcDg4oSI/3vO
         9G5MfV4ylOs5w2c9MLlCt+U1DD+xl0cGlHiFAGohe+MhOT0Vw7MEeG1Pk7qfN2sLvcdE
         Hf0g==
X-Gm-Message-State: AOJu0YyLup92KL5QLViPSKVO0fa/jccrDPgArpfk4jXZ9s7WF/ifsTVC
	7Zy2FpRZOqpMUf+Fuzl62BMQ6DFroviNWohnfl6d42W0HSQ6v9rdtQV61lmvPjwUq+YUl+nhEmM
	C/iZK4BIOILSjblk/
X-Received: by 2002:a05:620a:24c3:b0:76f:27af:2797 with SMTP id m3-20020a05620a24c300b0076f27af2797mr21315832qkn.0.1698924312382;
        Thu, 02 Nov 2023 04:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT5geDHIolp0aNPY1+MLsvDeWC3teHeCm8p/b1jYgutWDc0LnG9FJFSFJHpLLBT8Z59NWKDA==
X-Received: by 2002:a05:620a:24c3:b0:76f:27af:2797 with SMTP id m3-20020a05620a24c300b0076f27af2797mr21315813qkn.0.1698924311978;
        Thu, 02 Nov 2023 04:25:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-153.dyn.eolo.it. [146.241.226.153])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a144700b0075ca4cd03d4sm2228731qkl.64.2023.11.02.04.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:25:11 -0700 (PDT)
Message-ID: <5a265e5541ab1de2258a6e61bd672ef5fb6be65f.camel@redhat.com>
Subject: Re: [PATCH] net: stmmac: Wait a bit for the reset to take effect
From: Paolo Abeni <pabeni@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Thu, 02 Nov 2023 12:25:07 +0100
In-Reply-To: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
References: 
	<AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 07:01 +0100, Bernd Edlinger wrote:
> otherwise the synopsys_id value may be read out wrong,
> because the GMAC_VERSION register might still be in reset
> state, for at least 1 us after the reset is de-asserted.
>=20
> Add a wait for 10 us before continuing to be on the safe side.

This looks like a bugfix: you should target explicitly the 'net' tree,
adding such tag into the subj. More importantly you should include a
suitable 'Fixes' tag.

Please send a new revision with the above changes. You can retain the
already collected reviewed tags.

Thanks,

Paolo


