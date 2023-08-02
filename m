Return-Path: <netdev+bounces-23519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE08276C4DD
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C351C211A1
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 05:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AFF110C;
	Wed,  2 Aug 2023 05:28:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39E15AF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 05:28:08 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A33DFE
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:28:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so71764651fa.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 22:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690954084; x=1691558884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmLyzcLmD1KU1vVEFa37f+XHOqeRTKpHzNGLuZY+pzg=;
        b=f3wMRu2m+CS+W0p3JspVMzwxdT2hm5HtGj4tNGFaPkhOdA+ULdGq2KPT7p4oHoQcrl
         5bemYkxYfJV9nSU+E02O5ecfkCK7nTVrZgVhU7UaN4FA5cZMqkCI5OWfFCe/nNVbXLVw
         OffAd5rHExxnPNd1pNLbS1FOXR1n5qwqd54CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690954084; x=1691558884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmLyzcLmD1KU1vVEFa37f+XHOqeRTKpHzNGLuZY+pzg=;
        b=fMUpqS2zmUXxLs5TEJcfqzjdPIx48hUW6mX6gj/CpykpHV8t7onrw+3w+gWYuCuvS6
         NLIgzD3JOIFqSbcKswuu9P2qiEC5VxkEZa1vjcAoESo1KZ+xPX2RF8Osk00002RBxBmo
         hi4cTCfZpR9q8UAN260jo/ZhzXlF52s9e5pjRbbYGht1ESbEj9nVTY4pl0VurH0eyydb
         o3vhNtGfMGa95Wl9A3Ws5KUothduXubznHkyzmcG4ML5YdBbfPiq2RsAvKSNTKSiZTBe
         BuOr5cZ9XvT6OQtZFelV64tCj+Y80QBUJu0sI9jESftBOiT5JAXc5rJ/nAjZCO2MtbkP
         HHnQ==
X-Gm-Message-State: ABy/qLbB79FaGe3AeTF4Yv24iEeRieXjcJwpyejyP90z41VAVnnEPxmd
	ev90/6jHlPsiEtPgu3i9b7DFqy/C4g1ypmaSqOgR7w==
X-Google-Smtp-Source: APBJJlFh7jyyjsR4wgNOX+3T3K9I4kBHi7tFu2e+DlW4AvNreIuGLOwFVMR5oBJR5HuJwp2I9Ep+6TeVjbAWP14iIKU=
X-Received: by 2002:a2e:7308:0:b0:2b9:b3e9:a027 with SMTP id
 o8-20020a2e7308000000b002b9b3e9a027mr4119302ljc.34.1690954084447; Tue, 01 Aug
 2023 22:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZMklUch+vfZBqfAr@kernel.org> <PUZP153MB0788A2C4FC7A76D2CDD021BCCC0AA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PUZP153MB0788A2C4FC7A76D2CDD021BCCC0AA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 2 Aug 2023 10:57:52 +0530
Message-ID: <CAH-L+nPsuoJfCQcJnpMWk5DPGev8f+YWi0K4V+fU=5-bxP5GVw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH V7 net] net: mana: Fix MANA VF unload when
 hardware is
To: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Cc: Simon Horman <horms@kernel.org>, 
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>, 
	Ajay Sharma <sharmaajay@microsoft.com>, "leon@kernel.org" <leon@kernel.org>, 
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>, 
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>, vkuznets <vkuznets@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000905c4e0601e9edd0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000905c4e0601e9edd0
Content-Type: multipart/alternative; boundary="00000000000089c2fa0601e9ed9f"

--00000000000089c2fa0601e9ed9f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Souradeep,

It looks like the subject line is not complete. I could see "net: mana: Fix
MANA VF unload when hardware is".

Is that correct?

Regards,
Kalesh

On Wed, Aug 2, 2023 at 12:29=E2=80=AFAM Souradeep Chakrabarti <
schakrabarti@microsoft.com> wrote:

>
>
> >-----Original Message-----
> >From: Simon Horman <horms@kernel.org>
> >Sent: Tuesday, August 1, 2023 9:01 PM
> >To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> >Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> ><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> ><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> >kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
> >Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> >cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets
> ><vkuznets@redhat.com>; tglx@linutronix.de; linux-hyperv@vger.kernel.org;
> >netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> >rdma@vger.kernel.org; Souradeep Chakrabarti
> ><schakrabarti@microsoft.com>; stable@vger.kernel.org
> >Subject: [EXTERNAL] Re: [PATCH V7 net] net: mana: Fix MANA VF unload whe=
n
> >hardware is
> >
> >On Tue, Aug 01, 2023 at 05:29:13AM -0700, Souradeep Chakrabarti wrote:
> >
> >...
> >
> >Hi Souradeep,
> >
> >
> >> +    for (i =3D 0; i < apc->num_queues; i++) {
> >> +            txq =3D &apc->tx_qp[i].txq;
> >> +            while (skb =3D skb_dequeue(&txq->pending_skbs)) {
> >
> >W=3D1 builds with both clang-16 and gcc-12 complain that they would like=
 an
> >extra set of parentheses around an assignment used as a truth value.
> Thanks for letting me know. I will fix it in next version.
> >
> >> +                    mana_unmap_skb(skb, apc);
> >> +                    dev_consume_skb_any(skb);
> >> +            }
> >> +            atomic_set(&txq->pending_sends, 0);
> >> +    }
> >>      /* We're 100% sure the queues can no longer be woken up, because
> >>       * we're sure now mana_poll_tx_cq() can't be running.
> >>       */
> >> --
> >> 2.34.1
> >>
> >>
>
>

--=20
Regards,
Kalesh A P

--00000000000089c2fa0601e9ed9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Souradeep,<div><br></div><div>It looks like the su=
bject line is not complete. I could see &quot;net<font face=3D"arial, sans-=
serif">:=C2=A0<span style=3D"color:rgb(31,31,31);font-variant-ligatures:no-=
contextual">mana: Fix MANA VF unload when hardware is&quot;.</span></font><=
/div><div><font face=3D"arial, sans-serif"><span style=3D"color:rgb(31,31,3=
1);font-variant-ligatures:no-contextual"><br></span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"color:rgb(31,31,31);font-variant=
-ligatures:no-contextual">Is that=C2=A0correct?</span></font></div><div><fo=
nt face=3D"arial, sans-serif"><span style=3D"color:rgb(31,31,31);font-varia=
nt-ligatures:no-contextual"><br></span></font></div><div><font face=3D"aria=
l, sans-serif"><span style=3D"color:rgb(31,31,31);font-variant-ligatures:no=
-contextual">Regards,</span></font></div><div><font face=3D"arial, sans-ser=
if"><span style=3D"color:rgb(31,31,31);font-variant-ligatures:no-contextual=
">Kalesh</span></font></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Aug 2, 2023 at 12:29=E2=80=AFAM Soura=
deep Chakrabarti &lt;<a href=3D"mailto:schakrabarti@microsoft.com">schakrab=
arti@microsoft.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><br>
<br>
&gt;-----Original Message-----<br>
&gt;From: Simon Horman &lt;<a href=3D"mailto:horms@kernel.org" target=3D"_b=
lank">horms@kernel.org</a>&gt;<br>
&gt;Sent: Tuesday, August 1, 2023 9:01 PM<br>
&gt;To: Souradeep Chakrabarti &lt;<a href=3D"mailto:schakrabarti@linux.micr=
osoft.com" target=3D"_blank">schakrabarti@linux.microsoft.com</a>&gt;<br>
&gt;Cc: KY Srinivasan &lt;<a href=3D"mailto:kys@microsoft.com" target=3D"_b=
lank">kys@microsoft.com</a>&gt;; Haiyang Zhang<br>
&gt;&lt;<a href=3D"mailto:haiyangz@microsoft.com" target=3D"_blank">haiyang=
z@microsoft.com</a>&gt;; <a href=3D"mailto:wei.liu@kernel.org" target=3D"_b=
lank">wei.liu@kernel.org</a>; Dexuan Cui<br>
&gt;&lt;<a href=3D"mailto:decui@microsoft.com" target=3D"_blank">decui@micr=
osoft.com</a>&gt;; <a href=3D"mailto:davem@davemloft.net" target=3D"_blank"=
>davem@davemloft.net</a>; <a href=3D"mailto:edumazet@google.com" target=3D"=
_blank">edumazet@google.com</a>;<br>
&gt;<a href=3D"mailto:kuba@kernel.org" target=3D"_blank">kuba@kernel.org</a=
>; <a href=3D"mailto:pabeni@redhat.com" target=3D"_blank">pabeni@redhat.com=
</a>; Long Li &lt;<a href=3D"mailto:longli@microsoft.com" target=3D"_blank"=
>longli@microsoft.com</a>&gt;; Ajay<br>
&gt;Sharma &lt;<a href=3D"mailto:sharmaajay@microsoft.com" target=3D"_blank=
">sharmaajay@microsoft.com</a>&gt;; <a href=3D"mailto:leon@kernel.org" targ=
et=3D"_blank">leon@kernel.org</a>;<br>
&gt;<a href=3D"mailto:cai.huoqing@linux.dev" target=3D"_blank">cai.huoqing@=
linux.dev</a>; <a href=3D"mailto:ssengar@linux.microsoft.com" target=3D"_bl=
ank">ssengar@linux.microsoft.com</a>; vkuznets<br>
&gt;&lt;<a href=3D"mailto:vkuznets@redhat.com" target=3D"_blank">vkuznets@r=
edhat.com</a>&gt;; <a href=3D"mailto:tglx@linutronix.de" target=3D"_blank">=
tglx@linutronix.de</a>; <a href=3D"mailto:linux-hyperv@vger.kernel.org" tar=
get=3D"_blank">linux-hyperv@vger.kernel.org</a>;<br>
&gt;<a href=3D"mailto:netdev@vger.kernel.org" target=3D"_blank">netdev@vger=
.kernel.org</a>; <a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D"=
_blank">linux-kernel@vger.kernel.org</a>; linux-<br>
&gt;<a href=3D"mailto:rdma@vger.kernel.org" target=3D"_blank">rdma@vger.ker=
nel.org</a>; Souradeep Chakrabarti<br>
&gt;&lt;<a href=3D"mailto:schakrabarti@microsoft.com" target=3D"_blank">sch=
akrabarti@microsoft.com</a>&gt;; <a href=3D"mailto:stable@vger.kernel.org" =
target=3D"_blank">stable@vger.kernel.org</a><br>
&gt;Subject: [EXTERNAL] Re: [PATCH V7 net] net: mana: Fix MANA VF unload wh=
en<br>
&gt;hardware is<br>
&gt;<br>
&gt;On Tue, Aug 01, 2023 at 05:29:13AM -0700, Souradeep Chakrabarti wrote:<=
br>
&gt;<br>
&gt;...<br>
&gt;<br>
&gt;Hi Souradeep,<br>
&gt;<br>
&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; apc-&gt;num_queues; i++) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 txq =3D &amp;apc-&gt;tx=
_qp[i].txq;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (skb =3D skb_dequ=
eue(&amp;txq-&gt;pending_skbs)) {<br>
&gt;<br>
&gt;W=3D1 builds with both clang-16 and gcc-12 complain that they would lik=
e an<br>
&gt;extra set of parentheses around an assignment used as a truth value.<br=
>
Thanks for letting me know. I will fix it in next version.<br>
&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mana_unmap_skb(skb, apc);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dev_consume_skb_any(skb);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 atomic_set(&amp;txq-&gt=
;pending_sends, 0);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 /* We&#39;re 100% sure the queues can no longe=
r be woken up, because<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* we&#39;re sure now mana_poll_tx_cq() c=
an&#39;t be running.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt; --<br>
&gt;&gt; 2.34.1<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div>

--00000000000089c2fa0601e9ed9f--

--000000000000905c4e0601e9edd0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEICkC1dLMbQYHEwvSTS1f/WRghkltwC9rkBWl/8oI4bh4MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgwMjA1MjgwNFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBwQoVs56gJ
yLANFsvTCTI6gcU0fnZxONtoaOTGSvJDLapx1ysUKTQ2/7ntGUXCjG32V4r52RCf8LtoTq0Oh0HE
O6EJprwWeQbpwtzTyYZYseIqEIdgXnqeH/ektg3sgjewI7DKDacF6KEzHy+gLOsKRNHsvbWpQG2j
mUGOib+zB1o4TQ763Vs80B+N0+wnTdyf/vz/jbMI9pQIU5Fk/H7OxtCM0ogrdnSvsN4yK9Oj+QBz
6KhDnNE2XkMLc9tkEUm/g0XyYdXq2JGxZU9qmzF5E1gyVQuWTdRAMqR0+SMBgEl3t7C3LISEcwTe
oTh1SDZGlZ4Q1YDJkEPN4lJ2ni1X
--000000000000905c4e0601e9edd0--

