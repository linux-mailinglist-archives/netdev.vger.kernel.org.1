Return-Path: <netdev+bounces-59491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2994F81B0B5
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 09:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2BE1C209F8
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 08:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3389E1B271;
	Thu, 21 Dec 2023 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9ZCSyie"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927A1A72A
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703148743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7X7gmc4/l29hpAVyJ8b4AW2EtmNt/iVyKE8KES1vr/o=;
	b=O9ZCSyieLXNjHxbkdraEi7qS1T0Jf2lXs18kOvdZOLpVfBbl6GxtJBjPRKOb+bOqb2iUSw
	vIE1rGAsPN6zPlg9EWjIGisJdCezz0NiOT7of+ICm/MkuZFnpujk1oiFfGIVC2toZ07zXk
	5eZWh4DI92oR98SrBTFVaf9KWRjxQGU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-mUSRRpT_NeC7_aP-_gp5GQ-1; Thu, 21 Dec 2023 03:52:21 -0500
X-MC-Unique: mUSRRpT_NeC7_aP-_gp5GQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a236e1a1720so6210366b.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703148740; x=1703753540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7X7gmc4/l29hpAVyJ8b4AW2EtmNt/iVyKE8KES1vr/o=;
        b=dXCMQuTr91GBin7vJqJ4KqCPWC4qjr6lN3tWF6zA3yDBGg46kcTJFQfbfmAy4CBWF6
         M8ORbsdxVr6XU975rQHjFDG4LyK1CmV7M1A5GZQ6qzR3CIkbyelS0Zm7dhZtOxIwuCWe
         foULcN00c9PvMrVQEbSKxDOMnpH4yQtei9joCfkhYE02LktJ6XRS/w7cqjsyvAu2qjHn
         CT2qrl1wTm9RMhouhrFSYdquLjuLoO+ikVd3k6+THUVPnIJZOiNrIV18lV30Zp+erQlN
         sgQXnlD1FjSYO6bRU4cFrxflf2N3VJ2io82wpBbMjQtfWvJXmc9LEcOSbv7VRe9vr3ZF
         8SdQ==
X-Gm-Message-State: AOJu0Yz4MXgqrUSunmszZaH5BilfCl3zzyLVVn+FwH6fjxz4OYzrFqGY
	UGMU7D9apRN4DdYmxNiMC/fFk7ebO9/3u9LEmWg+69pV9kQy8xf24B+oE5TLRf/BaFuRI2UD0SI
	UvaZbt0peH22l8PVM
X-Received: by 2002:a17:906:f586:b0:a24:71aa:5d9a with SMTP id cm6-20020a170906f58600b00a2471aa5d9amr5989567ejd.4.1703148740469;
        Thu, 21 Dec 2023 00:52:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkWOmvfm5Uc4lvCyixclsvCOA+olyWgz5y1O8rGNnBK5PHkuVgH/Hw/d0KoPDQe95elbqLbQ==
X-Received: by 2002:a17:906:f586:b0:a24:71aa:5d9a with SMTP id cm6-20020a170906f58600b00a2471aa5d9amr5989546ejd.4.1703148740174;
        Thu, 21 Dec 2023 00:52:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-124.dyn.eolo.it. [146.241.246.124])
        by smtp.gmail.com with ESMTPSA id p10-20020a170907910a00b00a26aaa47cc0sm166290ejq.129.2023.12.21.00.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 00:52:19 -0800 (PST)
Message-ID: <023377a7f227f8cd7d5eb73017dbe3f691b29b17.camel@redhat.com>
Subject: Re: [PATCH v3 net 0/4] qbv cycle time extension/truncation
From: Paolo Abeni <pabeni@redhat.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Faizal Rahim
	 <faizal.abdul.rahim@linux.intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 21 Dec 2023 09:52:18 +0100
In-Reply-To: <20231219165650.3amt4ftyt7gisz47@skbuf>
References: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
	 <20231219165650.3amt4ftyt7gisz47@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 18:56 +0200, Vladimir Oltean wrote:
> How are you testing the behavior, and who reported the issues / what prom=
pted
> the changes? Honestly I'm not very confident in the changes we're
> pushing down the linux-stable pipe. They don't look all that obvious, so
> I still think that having selftests would help.

I agree with Vladimir, this looks quite a bit too complex for a net fix
at this late point of the cycle. Given the period of the year, I think
it could be too late even for net-next - for this cycle.

It would be great if you could add some self-tests.

@Faizal: I understand your setup is quite complex, but it would be
great if you could come-up with something similar that could fit=20
tools/testing/selftests/net

Thanks!

Paolo


