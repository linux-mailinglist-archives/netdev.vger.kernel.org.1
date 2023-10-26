Return-Path: <netdev+bounces-44415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0C37D7E7D
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D56EB212BF
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4E41A591;
	Thu, 26 Oct 2023 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qeeSTzmY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3E16436
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:29:00 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202FF10E
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:28:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so10059a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698308937; x=1698913737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHTnFJcs/zb1X42gP/1gu9nIsKnDhG2sNpR1zu8AWMg=;
        b=qeeSTzmYBvHp7+6Yv/iDI/D5+btALrqKSbXuIqIMgZkXQJRJfAKCjlg8VeZeNvzt0U
         glvTY+HIo4Cqev/8xvQWwist9wHNaFfnZpLQFLS8Gi+GuCG6vJwN6KQ9w5rfAk4GrSrS
         EgYBLu8nWmo7ddkvZFOttFw8Fe1Uo8KpKckwsBa0JjD+5ZyIYO4Bw7PRirCeFI4vAa35
         RgmfzbwJcD1jJOfy9QpfhALW95Gooi4/jQ90TymWhWxPYoFlWpd2DZssUKVZbCkSV00h
         Y/dlXoSh2/zao+0OtSfN/vxMlK+nk2fIDzVjgQiYRtI5ThealnEDN6kG3roP9oDEqyD+
         lJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698308937; x=1698913737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHTnFJcs/zb1X42gP/1gu9nIsKnDhG2sNpR1zu8AWMg=;
        b=GAYnSE6G4dOpDtzcIj7DdpWyKh0PlPdbUCP/f3VTQrkKbKRKnYXG1bmgRbwdNQecLp
         GCbaDlAbjJibIT71+J7JuRbB/CpBU+uAdznP/mSGkWOtZhhh15dPVuKptxf7/NpNmruY
         zziWM/gcYtQxO43rbWCcNNLyCmis8B0E8zataN9xkCBYTjo0u9jrgkUGRFY9LppljdCm
         Qt56y1Ty/D3mmFfbJB/9CqKDaR4KYzLLlUi0CyhPEG8CHnt2bd/tOipVkcPW8BKCoJaA
         pqEBa13R6EshS7nsk2cbuYz7ntgClRu7YDMQtAQ6vskLuV4dJ//zHltWteMuOiW0Lxag
         fgWg==
X-Gm-Message-State: AOJu0YxyxnXZ4HY7r7aObPUe8WqlGAbQjxMOrR/mQae42qBNzavE90+P
	5PPoV9cTcqB4PgtcmRjJEnA6h3ML8M/L1Z4AhZ19EOZpeae8jP0eas79cA==
X-Google-Smtp-Source: AGHT+IGOwpi2fW9KqiCeMSdiPgD7tYE+oJtILLrdFelOmMw2Ngoce0v2/l6TETbREzJm2ekFULZ+ZGFr1k9YgC2okVI=
X-Received: by 2002:aa7:da95:0:b0:540:e46d:1ee8 with SMTP id
 q21-20020aa7da95000000b00540e46d1ee8mr232051eds.4.1698308937317; Thu, 26 Oct
 2023 01:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024145119.2366588-1-srasheed@marvell.com>
 <20231024145119.2366588-4-srasheed@marvell.com> <20231024172151.5fd1b29a@kernel.org>
 <PH0PR18MB473482180622D7C163B487ADC7DDA@PH0PR18MB4734.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB473482180622D7C163B487ADC7DDA@PH0PR18MB4734.namprd18.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Oct 2023 10:28:44 +0200
Message-ID: <CANn89iKAn0-KBr00qrVibeM9Y7OqxDsg-keQQkty9oD1aCVtcA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more
 in transmit
To: Shinas Rasheed <srasheed@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani <hgani@marvell.com>, 
	Vimlesh Kumar <vimleshk@marvell.com>, "egallen@redhat.com" <egallen@redhat.com>, 
	"mschmidt@redhat.com" <mschmidt@redhat.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"wizhao@redhat.com" <wizhao@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>, 
	Veerasenareddy Burru <vburru@marvell.com>, Sathesh B Edara <sedara@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 9:58=E2=80=AFAM Shinas Rasheed <srasheed@marvell.co=
m> wrote:
>
> Hi Jakub,
>
> Again, thanks for your review.
>
> > Does this guarantee that a full-sized skb can be accommodated?
> >> I assume by full-sized skb you mean a non-linear skb with MAX_SG_FRAGS=
 elements in frags array.  Yes, this can be accommodated and the hardware u=
ses separate SG list memory to siphon these skb frags instead of obtaining =
them from the same tx hardware queue. What I'm trying to say is, this means=
 that a single tx descriptor will be enough for a full-sized skb as well, a=
s hardware can pick up SG frags from separate memory and doesn't require se=
parate descriptors.
>
> >If so - consider stopping stopping the queue when the condition is not t=
rue.
> >> We do stop the queue if tx queue is full, as in octep_iq_full_check ea=
rlier on.
>
> >The recommended way of implementing 'driver flow control'
> is to stop the queue once next packet may not fit, and then use
> netif_xmit_stopped() when deciding whether we need to flush or we can
> trust xmit_more. see
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.kernel.org_doc=
_html_next_networking_driver.html-23transmit-2Dpath-2Dguidelines&d=3DDwICAg=
&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D1OxLD4y-oxrlgQ1rjXgWtmLz1pnaDjD96sDq-cKUwK4=
&m=3DFyJHTb5Z2u9DTFSYPU38S5kPcP5KvwGWzY-DPcqOl1gdnm7ToZhTFpyvhLMqh1hd&s=3Dd=
BMmwfWKAi0UH3nrz7j9kYnAodDjuN3LZ5tC2aL_Prs&e=3D
>
> >> In the skeleton code above, as I understand each tx desc holds a skb f=
rag and hence there can be possibility of receiving a full-sized skb, stopp=
ing the queue but on receiving another normal skb we should observe our que=
ue to be stopped. This doesn't arise in our case as even if the skb is full=
-sized, it will only use a single tx descriptor so we can be sure if queue =
has been stopped, the write index will only be updated once posted (and rea=
d) tx descriptors are processed in napi context and queues awoken.
>
> Please correct me if I'm wrong anywhere (sorry if so) to further my under=
standing, and again thanks for your time!

Fact that octep_start_xmit() can return NETDEV_TX_BUSY is very suspicious.

I do not think a driver can implement xmit_more and keep
NETDEV_TX_BUSY at the same time.

Please make sure to remove NETDEV_TX_BUSY first, by stopping the queue earl=
ier.

