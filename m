Return-Path: <netdev+bounces-60164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4AA81DEDE
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 08:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F3B1F21318
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B166139E;
	Mon, 25 Dec 2023 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kayswKki"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1615A8
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2340c803c6so414551966b.0
        for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 23:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703490759; x=1704095559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzBgT1IsgIHrYIkRmXZCqjRIslOBcvcoDE5q0v7kiK0=;
        b=kayswKkiIUdwCIHTn6pIVQozecRmBWQ1/D1Xmjrsi6ZOzMWNix8eg29UuZPfIp/uNy
         IDghxZE44pmucF5G5PasP0Jb5QiRFl+tlPDhWHMKHzYcMglcmyr75vh1XgXDPuTVh/7g
         4B53V8mNZ0sGtKoEs5ckRkCLCN8Nf88gOEHlTG8+P3CGnReJIFSDAmk8OF7VJOdvinwP
         pyu1+E/+QF4jYCjSPc1LFhsGfFge5v6BmABfGqTaTm+Y6RkeqYVvt7RIPD9jxMUKRcFo
         vmWJSoeZluwpGZKkiM9lNHKjjcw3IZ1l1AEnPgP4yy0DKwacgFpVx1vwXNxEIXyBkHgA
         a+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703490759; x=1704095559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzBgT1IsgIHrYIkRmXZCqjRIslOBcvcoDE5q0v7kiK0=;
        b=TRWB+6KaMPhUx76tXOqMsGlLPuktJjoRIBupaIZgcwPKzUUlyyV5YPQd2LPHoXPE9i
         ozkSIQKFXUBMYr603xsk/52aWjeOnJ7Zv5dM/3LNP/FjaYM6eY+EM4QrbXl/lGswKEjv
         a3LnLjp4UD+8c4Uwifk9bF4JLc+gYXITXqVbAykT8u/k+WyySevhhyw+1VFiEF+ot19W
         vfXh2j6rpctGheBkamDfwm2H+oyLRt8hRlOur8SuLg/Zi21Dpsl8A+mueEyzvv4ER55y
         LCObz1nelcBz4SPPL8v9gln2S+zTnJEWa0w52gBVTBYh+DQ6XYLwMTs7FQ4T2lHvVngj
         zJTQ==
X-Gm-Message-State: AOJu0YzAic9whA+dCOOa4OYAS2NFaXRUv+yOBZNc7Rhu/iqgWWH/VLqU
	/lfvdH4453c/9RElwgC8Zqt2DPevZmj/vuiLiCE=
X-Google-Smtp-Source: AGHT+IEPwyYSdPkSHJRGh23HEDCJAuNKRuIOemDugAAW34KjB6cT5b/fEnckDKErUDnIZ+8tb7tPRx6q7AQ68I2la8s=
X-Received: by 2002:a17:906:220c:b0:a26:e4dc:1e17 with SMTP id
 s12-20020a170906220c00b00a26e4dc1e17mr817964ejs.31.1703490759200; Sun, 24 Dec
 2023 23:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch> <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch> <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
 <CAL+tcoDM+Kqu1=11m5gc58vY3uKVA6JiggBy_FyCghHY3Za0Qw@mail.gmail.com>
 <CACGkMEsDFTPUVXfSj5FGTK_722F1QkKHJG3GNV3qvsaKATZV_w@mail.gmail.com>
 <CAL+tcoA_kXEb2uBznUY8A+-uVcB_rXx1j39Wt8UTNx+6F0iHNA@mail.gmail.com> <CACGkMEspead380Sx-5HRjAO4LYc+R2EM+-K-7cYYuus72gPXbw@mail.gmail.com>
In-Reply-To: <CACGkMEspead380Sx-5HRjAO4LYc+R2EM+-K-7cYYuus72gPXbw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 25 Dec 2023 15:52:02 +0800
Message-ID: <CAL+tcoD6oqSGyNgP8scLnHBnHthXY4KGjtL_Y74tSNajppcJKQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 2:45=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Dec 25, 2023 at 2:34=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Mon, Dec 25, 2023 at 12:14=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Mon, Dec 25, 2023 at 10:25=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > Hello Jason,
> > > > On Fri, Dec 22, 2023 at 10:36=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Heng Qi wrote:
> > > > > > >
> > > > > > >
> > > > > > > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruij=
n =E5=86=99=E9=81=93:
> > > > > > > > Heng Qi wrote:
> > > > > > > >> virtio-net has two ways to switch napi_tx: one is through =
the
> > > > > > > >> module parameter, and the other is through coalescing para=
meter
> > > > > > > >> settings (provided that the nic status is down).
> > > > > > > >>
> > > > > > > >> Sometimes we face performance regression caused by napi_tx=
,
> > > > > > > >> then we need to switch napi_tx when debugging. However, th=
e
> > > > > > > >> existing methods are a bit troublesome, such as needing to
> > > > > > > >> reload the driver or turn off the network card.
> > > > >
> > > > > Why is this troublesome? We don't need to turn off the card, it's=
 just
> > > > > a toggling of the interface.
> > > > >
> > > > > This ends up with pretty simple code.
> > > > >
> > > > > > So try to make
> > > > > > > >> this update.
> > > > > > > >>
> > > > > > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > The commit does not explain why it is safe to do so.
> > > > > > >
> > > > > > > virtnet_napi_tx_disable ensures that already scheduled tx nap=
i ends and
> > > > > > > no new tx napi will be scheduled.
> > > > > > >
> > > > > > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack=
 cannot
> > > > > > > send the packet.
> > > > > > >
> > > > > > > Then we can safely toggle the weight to indicate where to cle=
ar the buffers.
> > > > > > >
> > > > > > > >
> > > > > > > > The tx-napi weights are not really weights: it is a boolean=
 whether
> > > > > > > > napi is used for transmit cleaning, or whether packets are =
cleaned
> > > > > > > > in ndo_start_xmit.
> > > > > > >
> > > > > > > Right.
> > > > > > >
> > > > > > > >
> > > > > > > > There certainly are some subtle issues with regard to pausi=
ng/waking
> > > > > > > > queues when switching between modes.
> > > > > > >
> > > > > > > What are "subtle issues" and if there are any, we find them.
> > > > > >
> > > > > > A single runtime test is not sufficient to exercise all edge ca=
ses.
> > > > > >
> > > > > > Please don't leave it to reviewers to establish the correctness=
 of a
> > > > > > patch.
> > > > >
> > > > > +1
> > > > >
> > > > [...]
> > > > > And instead of trying to do this, it would be much better to opti=
mize
> > > > > the NAPI performance. Then we can drop the orphan mode.
> > > >
> > [...]
> > > > Do you mean when to call skb_orphan()? If yes, I just want to provi=
de
> > > > more information that we also have some performance issues where th=
e
> > > > flow control takes a bad effect, especially under some small
> > > > throughput in our production environment.
> > >
> > > I think you need to describe it in detail.
> >
> > Some of the details were described below in the last email. The
> > decreased performance happened because of flow control: the delay of
> > skb free means the delay
>
> What do you mean by delay here? Is it an interrupt delay? If yes, Does
> it work better if you simply remove

Delay means the interval between start_xmit() to skb free. I counted
some numbers and then found out that some of them have very long
intervals which might be normal?

$ sudo bpftrace txcompletion.bt
Attaching 4 probes...
trace from virtio start_xmit() to tcp_wfree() longer than 0 ns
^C

@average: 384386
@count: 348302
@hist:
[1K, 2K)            9551 |@@@@                                             =
   |
[2K, 4K)          116513 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[4K, 8K)           88295 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          =
   |
[8K, 16K)          39965 |@@@@@@@@@@@@@@@@@                                =
   |
[16K, 32K)         39584 |@@@@@@@@@@@@@@@@@                                =
   |
[32K, 64K)         53970 |@@@@@@@@@@@@@@@@@@@@@@@@                         =
   |
[64K, 128K)          415 |                                                 =
   |
[128K, 256K)           0 |                                                 =
   |
[256K, 512K)           0 |                                                 =
   |
[512K, 1M)             0 |                                                 =
   |
[1M, 2M)               0 |                                                 =
   |
[2M, 4M)               0 |                                                 =
   |
[4M, 8M)               0 |                                                 =
   |
[8M, 16M)              0 |                                                 =
   |
[16M, 32M)             0 |                                                 =
   |
[32M, 64M)             0 |                                                 =
   |
[64M, 128M)            0 |                                                 =
   |
[128M, 256M)           0 |                                                 =
   |
[256M, 512M)           0 |                                                 =
   |
[512M, 1G)             0 |                                                 =
   |
[1G, 2G)               0 |                                                 =
   |
[2G, 4G)               9 |                                                 =
   |

>
> virtqueue_enable_cb_delayed() with virtqueue_enable_cb()? As the
> former may delay the interrupt more or less depend on the traffic.

Due to the complexity of the production environment, I suspect the
interrupt could be delayed on the host.

Thanks for the suggestion.

>
> > of decreasing of sk_wmem_alloc, then it will
> > hit the limit of TSQ mechanism, finally causing transmitting slowly in
> > the TCP layer.
>
> TSQ might work better with BQL which virtio-net doesn't have right now.
>
> >
> > >
> > > > What strikes me as odd is if I restart the network, then the issue
> > > > will go with the wind. I cannot reproduce it in my testing machine.
> > > > One more thing: if I force skb_orphan() the current skb in every
> > > > start_xmit(), it could also solve the issue but not in a proper way=
.
> > > > After all, it drops the flow control... :S
> > >
> > > Yes, that's the known issue.
> >
> > Really? Did you have some numbers or have some discussion links to
> > share? I failed to reproduce on my testing machine, probably the short
> > rtt is the key/obstacle.
>
> I basically mean it is a known side effect of skb_orphan() as it might
> decrease sk_wmem_alloc too early.

Oh, I got it wrong :(

>
> Thanks
>
>
> >
> > @Eric, it seems it still exists.
> >
> > Thanks,
> > Jason
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks,
> > > > Jason
> > > > >
> > > > > >
> > > > > > The napi_tx and non-napi code paths differ in how they handle a=
t least
> > > > > > the following structures:
> > > > > >
> > > > > > 1. skb: non-napi orphans these in ndo_start_xmit. Without napi =
this is
> > > > > > needed as delay until the next ndo_start_xmit and thus completi=
on is
> > > > > > unbounded.
> > > > > >
> > > > > > When switching to napi mode, orphaned skbs may now be cleaned b=
y the
> > > > > > napi handler. This is indeed safe.
> > > > > >
> > > > > > When switching from napi to non-napi, the unbound latency resur=
faces.
> > > > > > It is a small edge case, and I think a potentially acceptable r=
isk, if
> > > > > > the user of this knob is aware of the risk.
> > > > > >
> > > > > > 2. virtqueue callback ("interrupt" masking). The non-napi path =
enables
> > > > > > the interrupt (disables the mask) when available descriptors fa=
lls
> > > > > > beneath a low watermark, and reenables when it recovers above a=
 high
> > > > > > watermark. Napi disables when napi is scheduled, and reenables =
on
> > > > > > napi complete.
> > > > > >
> > > > > > 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls b=
elow
> > > > > > a low watermark, the driver stops the stack for queuing more pa=
ckets.
> > > > > > In napi mode, it schedules napi to clean packets. See the calls=
 to
> > > > > > netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue a=
nd
> > > > > > netif_tx_wake_queue.
> > > > > >
> > > > > > Some if this can be assumed safe by looking at existing analogo=
us
> > > > > > code, such as the queue stop/start in virtnet_tx_resize.
> > > > > >
> > > > > > But that all virtqueue callback and dev_queue->state transition=
s are
> > > > > > correct when switching between modes at runtime is not trivial =
to
> > > > > > establish, deserves some thought and explanation in the commit
> > > > > > message.
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > >
> > >
> >
>

