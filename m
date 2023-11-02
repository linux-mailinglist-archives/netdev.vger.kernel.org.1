Return-Path: <netdev+bounces-45695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A492B7DF0FE
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35411C20DC7
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB514273;
	Thu,  2 Nov 2023 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyRQN0WY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADB14270
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 11:15:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E75E188
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698923698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5X9zXTo8eLbZpNfNphwqZUMseNZ35B8f3qHoWgzx6M0=;
	b=UyRQN0WYcFSZz4Dn8thqtY2nYcsdFEHEO2KsSUU928Svs0IA2cXzLRNAq0LboOcLTAXviP
	UNFYGa3KMwpLMP7JviHXnc5bgcljhLYRvNhuyXuyeNY73NPBDErXhL+/o05fWC1emUoH8s
	iHtdMd5DcuDtLGHprPr3mnmSm+Gbb3U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-bsGnj8LpPg6Lw6tNnBN4LQ-1; Thu, 02 Nov 2023 07:14:57 -0400
X-MC-Unique: bsGnj8LpPg6Lw6tNnBN4LQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c3e3672dc8so1137691fa.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 04:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698923695; x=1699528495;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5X9zXTo8eLbZpNfNphwqZUMseNZ35B8f3qHoWgzx6M0=;
        b=lk1nb/Q2NHETwOfkK7SUx38Q3FO48PEq2KKTCcxy6PqeIJSfl385nT7LtzS87eC/kX
         KQNWFUxSQIPpAEVvYXz8Y9KPxcKcPrz3n0uRvpGhmKVg9+5JvpY3GqucJRcLkvCnT+l+
         DwAmcSvlAeM/onDk1UEH4WWDz+VXX3QSiXTCUZuMg5EWwjwYFbPGb6KFS1Tv7RUWIYnq
         EoEAyfnyf5DnKOvlAvTA92VZSOj1Xg4sTIoIwU/Ou9xut+u66o9MI4/nydT3HEaovLqF
         svV1iJUmhE5iexCmYaKlziKVnemHFOtSqjYNDgBt6Wnaiq7Beqi2DWUAmeVgYs66QZFa
         dP7g==
X-Gm-Message-State: AOJu0YxkgB+6+NcqK8rMzya3bRfvVUZYqjvtTdgCALFgb2umpvXV53mW
	2wRNA27HanRWeg34K4FrrnSTYWG27ODCpCBHTtitnmqG7Ei4cZA5sb0rPwWJVQFEye0AWeoYGrL
	QcVZU/XMhTjqvkpHO
X-Received: by 2002:a2e:3306:0:b0:2c5:519:bb1b with SMTP id d6-20020a2e3306000000b002c50519bb1bmr12741483ljc.2.1698923695606;
        Thu, 02 Nov 2023 04:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIpcoz45TDqA5S9HUXzHFHPPonuHMZEBqFML5f/SHsIM081u0+qPTrXpL9C2SsQVtX6luAMw==
X-Received: by 2002:a2e:3306:0:b0:2c5:519:bb1b with SMTP id d6-20020a2e3306000000b002c50519bb1bmr12741468ljc.2.1698923695235;
        Thu, 02 Nov 2023 04:14:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-153.dyn.eolo.it. [146.241.226.153])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c1c9000b003fee567235bsm2654539wms.1.2023.11.02.04.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:14:54 -0700 (PDT)
Message-ID: <f41c06eafd983584647e7d61561ea6282cdb735e.camel@redhat.com>
Subject: Re: [PATCH net] dccp: check for ccid in ccid_hc_tx_send_packet
From: Paolo Abeni <pabeni@redhat.com>
To: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
Date: Thu, 02 Nov 2023 12:14:53 +0100
In-Reply-To: <20231028144136.3462-1-bragathemanick0908@gmail.com>
References: <20231028144136.3462-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-10-28 at 20:11 +0530, Bragatheswaran Manickavel wrote:
> ccid_hc_tx_send_packet might be called with a NULL ccid pointer
> leading to a NULL pointer dereference

You should describe how such event could happen.

> Below mentioned commit has similarly changes
> commit 276bdb82dedb ("dccp: check ccid before dereferencing")
>=20
> Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc71bc336c5061153b502

and add a suitable fixes here.

(beyond taking care of other critical code paths, as reported by Eric).

Thanks!

Paolo


