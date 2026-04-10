Return-Path: <netdev+bounces-277303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FcIJsq52GmmhQgAu9opvQ
	(envelope-from <netdev+bounces-277303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:50:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB23D4500
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906283004C7A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A811C3AE185;
	Fri, 10 Apr 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUV31dvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729A3ACF1D
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810953; cv=pass; b=EwOH95wtxUu3ifR44RJtiAJ6xSvfjGQzQvaU4hCfxNN8O8oZ7vIVA5VhlV6+t/eaCWlRGBJ0ChiP3D8jGtee/8SGfIbHtSclPzfkVhkGgbC4Zcvz8ykWV50mL0jYBk2PFDHUAh/tsfCWGV8mj3cQqvUGRXb9PJoTNablqDbVBjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810953; c=relaxed/simple;
	bh=6FiJu+BjvXNJmyw7qlfvfDWdh0oxLvy2LD04DomyEO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9sa41TueaXXpDkAMpbIGyRqEZqg0Q1MJ4uyAm+68psAmY3sI58kviGOGS488kAvm0jKGWMkkE+y/AClKwaUcoTEtQDaBWYLo8gUN7Ta3EbUitExXlBT17xvFoTuwWSlyB371/9cLy0jQVYt1jLpxWBMjVwPx5enzOAdCpDGY/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUV31dvl; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb20bcff5aso166817385a.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 01:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775810949; cv=none;
        d=google.com; s=arc-20240605;
        b=Q1zVGQKVXkMQ1stogNGWvffvo2BsaD4hQkpIl6aVjb7TWHJnJ2DzNOBTD/U2rqNAXr
         h4Z0TTXEVhH3U7LnP1xvR3EsUkiTdeP8KsMxN0vDcdmGtLlgqvAFGRb8lMh5Nl/hqit/
         nlGa7ZVpLa+VtP/m+lUL4L32QzcXjzxxr4+wXTkAf9nxHbNsdqruhPb3wqdNvKcznCLp
         uKAW71VNhvAZvQbZbm07/0KhFuNyfEO1U2yRjfmeJFX2+Tr4W3fPkMrtESh/DbscGKxg
         hZ8kfWk5P4vXgrNcWaqq8J+HRiGDHYUhqnEYU+Q+wta4X9U4gYpfTeEE5C/1LfbyuCUg
         nQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lBD8yZrNx2mS06bjZoqEXQsGeeYcf6wdYAt3sRhSvfc=;
        fh=ims/OAXt1euGXI/LKyy9XW9twYI94vrx/pL4bU5cgC8=;
        b=bxcKcOLoB94lJQ7GH5+cBMKBeTpj8SVhPaItYpOFHVXDONIHu0x7ESLC5+QXWYVtGx
         zgEVeZeh5vZ4nJxC6crvPgpYLPlwi8AsUxxPpysPiVyUApJb0LJPSehpLoYJ2eMK+9zE
         7XoF7YcxF2fgfzEt2+qSfAYIkUWbFP5pVaDuYmRWZAs7SP5/dFVCASJcqllc7h3HcdKl
         XscHs5E51eWDIF2zLxzPddcz5b9l4OyjeRjrZ7HDr7DTxpf8MRRzYU/F8hHJTj+J0W11
         S0C0cjRQwI5eGE1eR3gANisHlZ+wkEvQXH34Y4d2yOlTJ3h7nEryoylhGjiPaJ+7+aC8
         4a1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775810949; x=1776415749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBD8yZrNx2mS06bjZoqEXQsGeeYcf6wdYAt3sRhSvfc=;
        b=MUV31dvlPRuwXVA0n1W61PqM2k7OtlQUabp8+4DmtCifrjNBv0H16xfUYZap4fekkw
         rqrNGeqgfl8w+xfv2NBMAGN8o/j+1Zr8scV8GnJsqcIoLmkt0GFN4ekgPnIb3Nk64Kfy
         xTB41MKk0MhEDA94P55eMNwNmzpPOKPsLVzWRw9Gz5I/i0wSRfc4+709wSIhke8sCXb4
         E1vLO2CbN2BXwjBFaPd/RRHM3cR0jTacNauZAxC6zLtbZnC07vm58lkZ32tCDatOt52P
         +gSSi753pY/TFA97KTSc42fR0XN2AjNl3ErHAtxsA04TEiXwJSOIC3Z9FRBhTVWwb+fZ
         la5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775810949; x=1776415749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lBD8yZrNx2mS06bjZoqEXQsGeeYcf6wdYAt3sRhSvfc=;
        b=a9UUpEmQ9TW+fupuGToZukgrQ0OO6TXx6+APwkTKQxyhU9zheaVGl0Ile2RvlMRWcW
         JoG7sRxrTr1ysLs8GZHwHXK8SRJTf0TdAa5IQx4r6Y5bXb6DnIrht5LyfrNws54PW4BG
         gIAsM86WtpyrpR0h+btHfNCeX7Pbviy+izrxxEowN3kF0gjaM7JVCOT1LTL0pNDenF2/
         R7tsePDUY5Kv+UEP21bhX5mXjRZ6ilcAAHhchU2GVjvCNFFMY2LG4ddvTRxrT9lTndam
         f5zeON/ubFRBtC82nBIbt1UyL7ywJjUKwb4ZliZgrSFiCOwVByHjpQClascMLTRAM8PB
         Ipnw==
X-Gm-Message-State: AOJu0Ywt+Va1bVX9tPiqV3U/N5PP5lgmJYkomv4+FcLO810uK376XYdi
	7H+Gay8iGATAFW4MKvRiK0R2duI3psE2l9ARapGLlu3DPZx6Yi32zs+L0KyDa+tOBTDFh7Ve9tb
	AAlXZN2P4q457Vt9fm29prRLXgLr04b++QImhDWdO
X-Gm-Gg: AeBDiesamunnFw7NprYFqK4xP8geFtD7bAaXNogU1DQYOZgQRSwxidq8rfGYLd+ADVA
	tsRaeBP2w7SLhNAjzUCChoOfalA/Cc7Ji+mvTx0lgWQoo62sagQ+dIrtjmu/KtAiHDCyfMc6VeZ
	mdmn3fHK5KI738ADiZiJLani/Q/XyF6Ey4MFdtiuVkHr6xXGJ7EHIGpvffqhBT4iqmQuZnbjit5
	fDnHrHaN4F00mPHeNKCEETfI0Ii4XyUdMUddKLelUkN6oSsGmefOWoAeow/HxN1LXezc4oRjeOY
	jhvxiBS8dWPaI8e1ZqRL+6z2Cbjxbt8Mxdx22mTeaAjxxeCSTHRImLCQBxWAbLabtJOHdcZRIJE
	=
X-Received: by 2002:a05:622a:2d4:b0:50d:d7fc:23f0 with SMTP id
 d75a77b69052e-50dd7fc3202mr21013121cf.38.1775810948256; Fri, 10 Apr 2026
 01:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775731983.git.wangjiexun2025@gmail.com> <f6cbbc8da90e95584847b5ceb60aae830d1631c2.1775731983.git.wangjiexun2025@gmail.com>
In-Reply-To: <f6cbbc8da90e95584847b5ceb60aae830d1631c2.1775731983.git.wangjiexun2025@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Apr 2026 01:48:57 -0700
X-Gm-Features: AQROBzCJRzdYJkxnXuIzVJ5fXkk2yRDhmGbJ5PRN702Jpc7VaUi7GSVCgsD3C8Q
Message-ID: <CANn89iJ+rBzO3zmhQmpzXU_5cs-oRodVTCcNeGKSte-2xnb3kg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] af_unix: Hold receive queue lock in ioctl(SIOCATMARK)
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, rao.shoaib@oracle.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com, 
	bird@lzu.edu.cn, enjou1224z@gmail.com, wangjiexun2025@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277303-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,oracle.com,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lzu.edu.cn:email]
X-Rspamd-Queue-Id: EFBB23D4500
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 11:32=E2=80=AFPM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Jiexun Wang <wangjiexun2025@gmail.com>
>
> unix_ioctl() peeks at the receive queue and may check both the head skb
> and its successor while deciding whether SIOCATMARK should report the
> mark. However, u->iolock does not stabilize receive-queue element
> lifetime. Queue teardown paths can purge or splice the queue under
> sk->sk_receive_queue.lock and free the skb while unix_ioctl() still
> uses it.
>
> Take sk->sk_receive_queue.lock while inspecting the queue so the skb
> and next_skb stay alive for the whole decision.
>
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/unix/af_unix.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index b23c33df8b46..54f12d5cda37 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3301,6 +3301,8 @@ static int unix_ioctl(struct socket *sock, unsigned=
 int cmd, unsigned long arg)
>                         int answ =3D 0;
>
>                         mutex_lock(&u->iolock);
> +                       /* The receive queue lock keeps skb and next_skb =
alive. */
> +                       spin_lock(&sk->sk_receive_queue.lock);
>
>                         skb =3D skb_peek(&sk->sk_receive_queue);
>                         if (skb) {
> @@ -3315,6 +3317,7 @@ static int unix_ioctl(struct socket *sock, unsigned=
 int cmd, unsigned long arg)
>                                         answ =3D 1;
>                         }
>
> +                       spin_unlock(&sk->sk_receive_queue.lock);
>                         mutex_unlock(&u->iolock);
>
>                         err =3D put_user(answ, (int __user *)arg);

Ok, but I think we also should remove the READ_ONCE() now we have
proper locking.

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5d4baac499af8d0a9cc36f652acf129a2e3619b2..1c3b80b25ef8b37d8e6553066fb=
7da20d81294a5
100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3301,10 +3301,12 @@ static int unix_ioctl(struct socket *sock,
unsigned int cmd, unsigned long arg)
                        int answ =3D 0;

                        mutex_lock(&u->iolock);
+                       /* The receive queue lock keeps skb and
next_skb alive. */
+                       spin_lock(&sk->sk_receive_queue.lock);

                        skb =3D skb_peek(&sk->sk_receive_queue);
                        if (skb) {
-                               struct sk_buff *oob_skb =3D READ_ONCE(u->oo=
b_skb);
+                               struct sk_buff *oob_skb =3D u->oob_skb;
                                struct sk_buff *next_skb;

                                next_skb =3D skb_peek_next(skb,
&sk->sk_receive_queue);
@@ -3314,7 +3316,7 @@ static int unix_ioctl(struct socket *sock,
unsigned int cmd, unsigned long arg)
                                     (!oob_skb || next_skb =3D=3D oob_skb))=
)
                                        answ =3D 1;
                        }
-
+                       spin_unlock(&sk->sk_receive_queue.lock);
                        mutex_unlock(&u->iolock);

                        err =3D put_user(answ, (int __user *)arg);

