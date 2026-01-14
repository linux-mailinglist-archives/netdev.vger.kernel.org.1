Return-Path: <netdev+bounces-249945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2E5D2157D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFC1D302F838
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A8299A81;
	Wed, 14 Jan 2026 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/dGeYAy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z+VoP6Hs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E443AA4
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426321; cv=none; b=rUUdiSkeqQuyKNx8SDW4mt4X9Lu5+TxoS0jd867AQhhSKrBEg07lNpVUgBKbbstzYK9CugcOFHzMKc0rd/B17ipRaODwU5d1YDKdJreIQQJVg5OfNm9MCBNtdg6prnZ8pnNDCyJCkT9G/w6F1WYIHYBjE2GA5LmlGXbLXuco89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426321; c=relaxed/simple;
	bh=NcogG4KS7gcdjJ6bLzdkJrwiKvOTwRq6dwpXwBUQbcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk0BvJqsKmGplioiuAPkjYAOswdIsgiIvPRbM48f3h8r6Sqyi2nIpJ3883nYU4t3mWBDZ/pTMckXmhfdP6gkibU5/9ffIVxNHqFVBPzB9GlY42PGR/HpUPTJvA6o1uCOfL4srKVOWt2bjDFiHMzfZ1vc6x0/2eJpYWonkfSXhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/dGeYAy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z+VoP6Hs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EKsAYD3925615
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 21:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wzu6r/egvOq73eEwo8AgSlISThorKmPgNDcRZ+HtVRE=; b=c/dGeYAy1UQyyJ/q
	deqXridmz4A5FosuRar/8wqlt5eCl/IScH2cLaS0Z9bInzTIKjEJ+iDEdv17lFa5
	ebXPDsl6h/+yNIznlaiPhvpv+OjzlKwloCJ481MskqMI/zYq9XHoCNmTU0TMV092
	ooUGn8ykdW0il20gPPR4JZ3KhRKM9fHppWTwd+VXFykl/Xo6/LDFD5vmPGR5w3nx
	B4D1wOAC/wxcvxOXjkF3SGadgarah2VWW7hTZn3ww8JLBB8a2cOySADOq+/Cyo8A
	/F89Dmu18rz3vXlC6+vzrNaaMxxKLYvwbJu1HjSB1w8F/ST1uYOl8S3TwMNUy2sk
	a7NfXw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpbdbsqmh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 21:31:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b19a112b75so69908885a.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 13:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768426318; x=1769031118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzu6r/egvOq73eEwo8AgSlISThorKmPgNDcRZ+HtVRE=;
        b=Z+VoP6HsvjcgLs7mgg7F2yn+VDW8FPYzBlVX1L2oZj/MubKOgee8OumF+wH5/blzyo
         hHOtzaaA5MYObqsGMIDsjoBSdGuHmsyM7CZYDToQ8O8SVRGeH9XJtlqKd+VCbxsoWfyI
         Zf+gmbl8GC428CbLmafk8DQRvJatlJ0mNt6vbIZqvS+Hw2lap01vHeYOCtNjRL2lAX8O
         jHyL5nze+cR6UaZv067+NAhDYuK9hhm6wI/oVTvdLZD23vprV9EqJZX7H1YYqsyOS2Gn
         9c83QhBAOAEW9rQhXMV8dV+j4GMgHTgtu4CjMUB2YaeWhdf/u+D0PGKiUFME/HcL0Za/
         l6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426318; x=1769031118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wzu6r/egvOq73eEwo8AgSlISThorKmPgNDcRZ+HtVRE=;
        b=ErAGLxDai26NyJGa7fokwhA2JcREfLaJxK7DCGzWPAuzSgTym9TdAhpmYqua0DhThr
         gWVLYNfH0peEJdd3+HQZflMEV23kufPylm5hbg/CnXztQfelVIhu1OeCl8/IuIoIJxCY
         jyYCuXwKtB3W6npxbdzp6NNJb2vynTLXDnTl2lKZppG8esWy+qZxnm6QVBHzCaBmWGU9
         LE2s69fW6YAD8NSqXBjya37AEHPnXkbEZFyKI+Vg27RMX6JBNuzVVzJ1LrK3AK6+5qdD
         YhIB3mfMVSFAnA7V5AA8uTluE7I2+gy4Sl3gI2wDFox9HcKpOQiIUwxDuaNYGbPqUrCC
         3vxw==
X-Forwarded-Encrypted: i=1; AJvYcCWKBoXv0mB0K3e/o6/z83osme/MxVQBB16RbKbXEJzGOHXAmehXPZeelzOTktjDpEADlo5tt7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKiGdJNtPBhAM/FlgpwEPm5lNY0Fa1rL7GX65SIuwCJctUMCez
	G8bL9PlrT3dS1P3wm6i+AbN9sNV63qB3eqW999u2AM5ueT1BMarSu66ctgUpPI04FuAjwj0d0bL
	TNlLgRSLdyI2+sR20kaI/2xWp62Jeas9J5WgkNXaCkHz1Z6QBHrqWNtEH09HYkFmaIxJFONV2/3
	/bUVQrsPu5qACYMTNmEJpYL9Km/6A8cyzp3g==
X-Gm-Gg: AY/fxX4OgPzvSd0/JXyeZYPA3yJIci/UuNJIm+qP723IAedbididus0wV+LJ6GDnmbG
	lxtq84dU7V6GcXzdjRtOkT1ibopy6yYNvHzJ+xd8EKk3gtz5ynyhzjVJnYQccPnskWEsWvSjna9
	x+wQdmil69wz4ZWyebQKL8QfdHgviTXr4H5/uR4SHT1z3MV5wzpbZfswVGfsm/WROep0XWrpV/v
	XO2eSmu8gx8zjC+vHJlbTrGAa0=
X-Received: by 2002:a05:620a:4548:b0:8c3:6f1e:21ef with SMTP id af79cd13be357-8c531817a30mr426008485a.83.1768426317492;
        Wed, 14 Jan 2026 13:31:57 -0800 (PST)
X-Received: by 2002:a05:620a:4548:b0:8c3:6f1e:21ef with SMTP id
 af79cd13be357-8c531817a30mr426004785a.83.1768426317004; Wed, 14 Jan 2026
 13:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com> <20260109010909.4216-3-ryazanov.s.a@gmail.com>
In-Reply-To: <20260109010909.4216-3-ryazanov.s.a@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 22:31:45 +0100
X-Gm-Features: AZwV_Qi2qWXnaTPD8sVWOUWF97uc62E-RDdTMMaWZQ01PSjKlP2XQX_BQpPYSCQ
Message-ID: <CAFEp6-3n=125v7RDbbJaT2XPyt+adGfgY-pgXguymYVy+oxuaw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/7] net: wwan: core: explicit WWAN device
 reference counting
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=NvncssdJ c=1 sm=1 tr=0 ts=69680b4e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=DxpDhW-plvI_LDxOzYgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: ig_l1CONA7ywBS9U93KeKOqv6dh8bdKH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE3NiBTYWx0ZWRfX23t/TcAhj6K0
 x8ikstwLWkGh4DNSQR4dX+h68Ow0wqaoz5Jz2eGJ11VfQqL0Oq5AXrHp2I/3RvGEem62e0mtz8t
 A8/agr+kLLaoDCmalzEHXBY3MVbxC6BmTnHIip9myOFLQ2xt5oaWrTo4CVRt1k+DLxrMGqJ9uT7
 +BezCHeqtIDn8Njxgtb+RqdvfUfL7P8ncq4qeQnCV+zRdCf8qF0UQYmxV8swdZpNVl1gy0bLHyi
 8tEF09q0vPkaWdnBK0ki1V0jHjc7lBsdzqbCT1nWlfLN494uE0fvyf03U5vaaPA6W1mER3M7ZQ0
 VSSKXDuaA0FDAGS3hWig8hArZlP5330Po2QJsOHIVnV/r+42Vj8TnaqqzNofVvZ5erfQ6GlVm/Z
 BMOCSJlFOSoEgTm8G+0dahvA98fU+mBrlPlpQSl78PRGbZ9zU7Cp5CCKBurMYa23GAG/RvAOfN9
 32hK54JbSJ6sAHn8ijA==
X-Proofpoint-GUID: ig_l1CONA7ywBS9U93KeKOqv6dh8bdKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140176

On Fri, Jan 9, 2026 at 2:09=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gmail.=
com> wrote:
>
> We need information about existing WWAN device children since we remove
> the device after removing the last child. Previously, we tracked users
> implicitly by checking whether ops was registered and existence of a
> child device of the wwan_class class. Upcoming GNSS (NMEA) port type
> support breaks this approach by introducing a child device of the
> gnss_class class.
>
> And a modem driver can easily trigger a kernel Oops by removing regular
> (e.g., MBIM, AT) ports first and then removing a GNSS port. The WWAN
> device will be unregistered on removal of a last regular WWAN port. And
> subsequent GNSS port removal will cause NULL pointer dereference in
> simple_recursive_removal().
>
> In order to support ports of classes other than wwan_class, switch to
> explicit references counting. Introduce a dedicated counter to the WWAN
> device struct, increment it on every wwan_create_dev() call, decrement
> on wwan_remove_dev(), and actually unregister the WWAN device when there
> are no more references.
>
> Run tested with wwan_hwsim with NMEA support patches applied and
> different port removing sequences.
>
> Reported-by: Daniele Palmas <dnlplm@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fe=
cK1vnrghjG_e9UaRA@mail.gmail.com/
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
> Changes:
> * RFCv2->RFCv5: new patch to address modem disconnection / system
>   shutdown issues
> ---
>  drivers/net/wwan/wwan_core.c | 37 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ade8bbffc93e..33f7a140fba9 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -42,6 +42,9 @@ static struct dentry *wwan_debugfs_dir;
>   * struct wwan_device - The structure that defines a WWAN device
>   *
>   * @id: WWAN device unique ID.
> + * @refcount: Reference count of this WWAN device. When this refcount re=
aches
> + * zero, the device is deleted. NB: access is protected by global
> + * wwan_register_lock mutex.
>   * @dev: Underlying device.
>   * @ops: wwan device ops
>   * @ops_ctxt: context to pass to ops
> @@ -49,6 +52,7 @@ static struct dentry *wwan_debugfs_dir;
>   */
>  struct wwan_device {
>         unsigned int id;
> +       int refcount;
>         struct device dev;
>         const struct wwan_ops *ops;
>         void *ops_ctxt;
> @@ -222,8 +226,10 @@ static struct wwan_device *wwan_create_dev(struct de=
vice *parent)
>
>         /* If wwandev already exists, return it */
>         wwandev =3D wwan_dev_get_by_parent(parent);
> -       if (!IS_ERR(wwandev))
> +       if (!IS_ERR(wwandev)) {
> +               wwandev->refcount++;
>                 goto done_unlock;
> +       }
>
>         id =3D ida_alloc(&wwan_dev_ids, GFP_KERNEL);
>         if (id < 0) {
> @@ -242,6 +248,7 @@ static struct wwan_device *wwan_create_dev(struct dev=
ice *parent)
>         wwandev->dev.class =3D &wwan_class;
>         wwandev->dev.type =3D &wwan_dev_type;
>         wwandev->id =3D id;
> +       wwandev->refcount =3D 1;
>         dev_set_name(&wwandev->dev, "wwan%d", wwandev->id);
>
>         err =3D device_register(&wwandev->dev);
> @@ -263,30 +270,21 @@ static struct wwan_device *wwan_create_dev(struct d=
evice *parent)
>         return wwandev;
>  }
>
> -static int is_wwan_child(struct device *dev, void *data)
> -{
> -       return dev->class =3D=3D &wwan_class;
> -}
> -
>  static void wwan_remove_dev(struct wwan_device *wwandev)
>  {
> -       int ret;
> -
>         /* Prevent concurrent picking from wwan_create_dev */
>         mutex_lock(&wwan_register_lock);

FYI, you can use guarded mutex:
guard(mutex)(&wwan_register_lock);
This ensures the lock is 'automatically' released when leaving the
scope/function, and would save the below goto/out_unlock.

>
> -       /* WWAN device is created and registered (get+add) along with its=
 first
> -        * child port, and subsequent port registrations only grab a refe=
rence
> -        * (get). The WWAN device must then be unregistered (del+put) alo=
ng with
> -        * its last port, and reference simply dropped (put) otherwise. I=
n the
> -        * same fashion, we must not unregister it when the ops are still=
 there.
> -        */
> -       if (wwandev->ops)
> -               ret =3D 1;
> -       else
> -               ret =3D device_for_each_child(&wwandev->dev, NULL, is_wwa=
n_child);
> +       if (--wwandev->refcount <=3D 0) {
> +               struct device *child =3D device_find_any_child(&wwandev->=
dev);
> +
> +               if (WARN_ON(wwandev->ops))      /* Paranoid */

You may keep a reference to child (if existing)

> +                       goto out_unlock;
> +               if (WARN_ON(child)) {           /* Paranoid */
> +                       put_device(child);
> +                       goto out_unlock;
> +               }

Maybe you can simplify that with:
```
struct device *child =3D device_find_any_child(&wwandev->dev);
put_device(child) /* NULL param is ok */
if (WARN_ON(child || wwandev->ops))
    return; /* or goto */
```
>
> -       if (!ret) {
>  #ifdef CONFIG_WWAN_DEBUGFS
>                 debugfs_remove_recursive(wwandev->debugfs_dir);
>  #endif
> @@ -295,6 +293,7 @@ static void wwan_remove_dev(struct wwan_device *wwand=
ev)
>                 put_device(&wwandev->dev);
>         }
>
> +out_unlock:
>         mutex_unlock(&wwan_register_lock);
>  }
>
> --
> 2.52.0
>

Regards,
Loic

