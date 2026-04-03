Return-Path: <netdev+bounces-275160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLqHIKv+z2kr2QYAu9opvQ
	(envelope-from <netdev+bounces-275160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:53:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F53972DB
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48B9F3014664
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539B63C9EEE;
	Fri,  3 Apr 2026 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxw9Zij0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD83B19BE
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238718; cv=pass; b=pJkASPhJJKLqCd6SbDPCEI8R/udLPeMb/+sqy+bdXzCdU0l2HbVA2bjJGfN1vxsIZlm99LQRDi35ri4D7aWam2cDTkwOoNtEs1vdwL84cdF+gVhgLojwnveCckMR9k7tFWQcsJufx8a7Q/Whxo6RPFSzttTWivQEWuGNZfvxJlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238718; c=relaxed/simple;
	bh=/GuofaS6afgkYLOeabYbtCP6ad4zwgDCmyZW593Hcd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=it40B3DCY3lkIJoZidL5sSpdwlhnAVlPSFKFzXFF33RkxqObhbEazXTbw4PDDYZwY79q5deTV1D1ZN2L3+3jfcf8rcb8Yvm6na/YBpxViR/JlDWp6BPnCcZ3XuPpvy3WO//65ZQ8kjOE+CCscO5Z0YUTGRpUSMgq/lQpRdfTB0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxw9Zij0; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65005a8840dso2195773d50.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 10:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775238716; cv=none;
        d=google.com; s=arc-20240605;
        b=aNADclZsoGjn0fKL0Mdkpng29To2d76UAmedzjWtfzpC0ekgOe2vjm9IFwZWBS7SfW
         jJS6LdhxphvA5Ve4wbLim/wxpaGdwYVg0+O8VN/p/ucnmQaeDd5IkAadHZreYLanwPX/
         PhhiWWe2C/96oCLxwxZrjujh91t0JnBXxxT1ud8b3833NBL9tEqsxi8yLDdHlB3SACWD
         oKbFwD9YOA2gvRCLUnVZGg2DSri/Nq1vuirCwoW68aGWXVmvGUqAsidmWr0FYb4Ps0SM
         F2iqYnDJafMTjILtAPGiD/D7WpTtTtGXqyaOdVnn1ORk3USTLn7ezrk7fSmAO7/p/jXp
         37yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TuAxWFVTaAOtWl4GGnCFFHrE8RNuaXjTZ7b6KeFGrCs=;
        fh=3erh8Wu9IZG5YxF16CGB4TTznL65CUpcEKOzJPtZ/kg=;
        b=c8TAnWDc5jRnugI8lMucLZc6/sf2euL/VR2V6kWTkopXJnuVnwOFRh55Eh8e6LU66g
         kguib8/ifXBTsEPMrdycnymH82m4H14cswMX/uwqGi19nSMHA3pvU+PTXu7y+a/U4PpQ
         GDUBSsyVuyYCQlUUkdKDFE5Qh0ZA2lblJfmv2wvJLZi+NMTUZwCu0A7B3BxsL3CVfdWy
         MGYz3ei1twXF7SSIt1581YSCjwpoT1wHTygIjXW2N+/fr3dKH5Hlkh/0f6qEopTcfwCy
         4DDr18uyWKhFDj7QgbV0fB4GZMGNYbIyOrH9xf3DU1zFMdmPCxFwB2nbo1RseQ2VmAuj
         KiWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775238716; x=1775843516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuAxWFVTaAOtWl4GGnCFFHrE8RNuaXjTZ7b6KeFGrCs=;
        b=pxw9Zij0DhLjAwZWxJDEdDZGVhoEsNXQIF5F2tAZESRz4Zb9fKkvlFI5sjRLZQUKo+
         rk731GSc0MdPM7Ztr33ns/yqeRoM4POuEorYy+/mTXyYmYfA48K012SAUPh39Bw/MNyY
         zZrOEDwvDeQGEhAKgGSKRakMbiyNCHdVBgdbHZAW2RqMyCgJPwTGMFzmCpy4X8dt+Ynm
         YqQ4FpnGunRVe/pQqtbRulrA9AQP/LaHVlX6vae/q8oxCer0XkT7MT1U7kBSeDUy2q0J
         srOIG4rn01pz1+ef2H8UFGNsHqB3OwpXOjtP3cqIoPd6r7wqmxoNdPF2VlupjAQUcQPi
         5rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775238716; x=1775843516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TuAxWFVTaAOtWl4GGnCFFHrE8RNuaXjTZ7b6KeFGrCs=;
        b=QNhtfcYfMJledVOtVvbJuIQry+Slcj9m2UsPFmX+AfF+hRGpnTexiMDFRz1g+ggDjH
         7dBLNeqeTkcI9c1SC+zwTGxfsNkFhwpqtroG16/C8a4vrbs1jgx9nLZG1aA08zb6AfZZ
         JG1dPRgwN2GB/Aa7Zp95tXxSGXUw3RF/YUhGBFElqNS0/yTfVQxmxPA469wzjsDAHIv4
         FLvaTWHUQ8SXq0OYgXQtOf4vOXjVMbL3PSOR3MuLbDiLrxgSvpvk5fvBeONF2zBsV7c9
         vKDwxM3fA6O9NvnS5LITSwtfMyec5d9bhXXm+xmHdhhCOel3FRqxz19x8k5WBpUv/GlD
         3NBg==
X-Forwarded-Encrypted: i=1; AJvYcCXsdA/RkBV0s/FgfUhOte1P8UFWGA7aYFeH0EcZ3+reeGgEsCyAju3Z0bOmLPjEjFP+Bb4EOyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxud0zvGDp464YAqcys//LRYeoJQ/H2u8Ts++HwmBP51Tetps5s
	n2tUkkwtUoNpPfs9S2O1ukJASa75HgVs1aeBwtYkhNKZGiKWFm+IrD0eTQUpPvkCITLrpUvgqsS
	PTA7xTtU/dBY8wmi7tiAdLKxEE0DT+XY=
X-Gm-Gg: AeBDievIF9zhNSSBSXGxVXXe0tLqHE5REfFT+AJDLxUK9XmkKQS4DOxO3jOQKXP7Y1K
	tbuIE6932NkYXHEEYL9KyRIIs/PLwNTVkYQEftKCcFYRNeKpjoA6cOE0hDwDyaC8u4tWFfI35O4
	RAMIKFDBeMWAeNWu12gkFmxtMrGW3uEY7SkNmdNkFnYkbKmAmblhgKS7LslApU9LNJ2wqFUIWty
	ic9ZJV1crrb9APHIrc9/V3gGuLYVT5Tz3EnNB1chch7I/tkv+mMIQ2bGywBs1t460ET37V+blQe
	ydB+hjdnDTKzQRylP6OZqFeNqb2oEQqb3vqzb/pvVCYgdY7pKRSGRH3vCg5E5tZQursNohkuQ+X
	sIn4G
X-Received: by 2002:a53:d788:0:b0:650:1004:2a63 with SMTP id
 956f58d0204a3-65048800bcemr3215730d50.41.1775238715603; Fri, 03 Apr 2026
 10:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774454568.git.wangjiexun2025@gmail.com> <06a6b4549acba207847ce532dedbf1c95ab22d13.1774925231.git.wangjiexun2025@gmail.com>
In-Reply-To: <06a6b4549acba207847ce532dedbf1c95ab22d13.1774925231.git.wangjiexun2025@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Apr 2026 13:51:44 -0400
X-Gm-Features: AQROBzDTKUUzqU9uA1hHQ5ZCJJYBvEauL7y3n1VLZM7Rp50HabzKGJsWazQn-5k
Message-ID: <CABBYNZJbttf4VnqNJsnME8DEJU+bO635ySRWofEDF--M+X2rgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: serialize accept_q access
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	marcel@holtmann.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn, 
	enjou1224z@gmail.com, wangjiexun2025@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: BE0F53972DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ren,

On Fri, Apr 3, 2026 at 4:05=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Jiexun Wang <wangjiexun2025@gmail.com>
>
> bt_sock_poll() walks the accept queue without synchronization, while
> child teardown can unlink the same socket and drop its last reference.
>
> Protect accept_q with a dedicated lock for queue updates and polling.
> Also rework bt_accept_dequeue() to take temporary child references under
> the queue lock before dropping it and locking the child socket.
>
> Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> Changes in v2:
> - add Tested-by: Ren Wei <enjou1224z@gmail.com>
> - resend to the public Bluetooth/netdev lists
>
>  include/net/bluetooth/bluetooth.h |  1 +
>  net/bluetooth/af_bluetooth.c      | 85 +++++++++++++++++++++++--------
>  2 files changed, 66 insertions(+), 20 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 69eed69f7f26..3faea66b1979 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -398,6 +398,7 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src);
>  struct bt_sock {
>         struct sock sk;
>         struct list_head accept_q;
> +       spinlock_t accept_q_lock; /* protects accept_q */
>         struct sock *parent;
>         unsigned long flags;
>         void (*skb_msg_name)(struct sk_buff *, void *, int *);
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 2b94e2077203..f44e1ecc83d8 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -154,6 +154,7 @@ struct sock *bt_sock_alloc(struct net *net, struct so=
cket *sock,
>
>         sock_init_data(sock, sk);
>         INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
> +       spin_lock_init(&bt_sk(sk)->accept_q_lock);
>
>         sock_reset_flag(sk, SOCK_ZAPPED);
>
> @@ -214,6 +215,7 @@ void bt_accept_enqueue(struct sock *parent, struct so=
ck *sk, bool bh)
>  {
>         const struct cred *old_cred;
>         struct pid *old_pid;
> +       struct bt_sock *par =3D bt_sk(parent);
>
>         BT_DBG("parent %p, sk %p", parent, sk);
>
> @@ -224,9 +226,12 @@ void bt_accept_enqueue(struct sock *parent, struct s=
ock *sk, bool bh)
>         else
>                 lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>
> -       list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
>         bt_sk(sk)->parent =3D parent;
>
> +       spin_lock_bh(&par->accept_q_lock);
> +       list_add_tail(&bt_sk(sk)->accept_q, &par->accept_q);
> +       spin_unlock_bh(&par->accept_q_lock);
> +
>         /* Copy credentials from parent since for incoming connections th=
e
>          * socket is allocated by the kernel.
>          */
> @@ -254,45 +259,73 @@ EXPORT_SYMBOL(bt_accept_enqueue);
>   */
>  void bt_accept_unlink(struct sock *sk)
>  {
> +       struct sock *parent =3D bt_sk(sk)->parent;
> +
>         BT_DBG("sk %p state %d", sk, sk->sk_state);
>
> +       spin_lock_bh(&bt_sk(parent)->accept_q_lock);
>         list_del_init(&bt_sk(sk)->accept_q);
> -       sk_acceptq_removed(bt_sk(sk)->parent);
> +       spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
> +
> +       sk_acceptq_removed(parent);
>         bt_sk(sk)->parent =3D NULL;
>         sock_put(sk);
>  }
>  EXPORT_SYMBOL(bt_accept_unlink);
>
> +static struct sock *bt_accept_get(struct sock *parent, struct sock *sk)
> +{
> +       struct bt_sock *bt =3D bt_sk(parent);
> +       struct sock *next =3D NULL;
> +
> +       /* accept_q is modified from child teardown paths too, so take a
> +        * temporary reference before dropping the queue lock.
> +        */
> +       spin_lock_bh(&bt->accept_q_lock);
> +
> +       if (sk) {
> +               if (bt_sk(sk)->parent !=3D parent)
> +                       goto out;
> +
> +               if (!list_is_last(&bt_sk(sk)->accept_q, &bt->accept_q)) {
> +                       next =3D &list_next_entry(bt_sk(sk), accept_q)->s=
k;
> +                       sock_hold(next);
> +               }
> +       } else if (!list_empty(&bt->accept_q)) {
> +               next =3D &list_first_entry(&bt->accept_q,
> +                                        struct bt_sock, accept_q)->sk;
> +               sock_hold(next);
> +       }
> +
> +out:
> +       spin_unlock_bh(&bt->accept_q_lock);
> +       return next;
> +}
> +
>  struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newso=
ck)
>  {
> -       struct bt_sock *s, *n;
> -       struct sock *sk;
> +       struct sock *sk, *next;
>
>         BT_DBG("parent %p", parent);
>
>  restart:
> -       list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q=
) {
> -               sk =3D (struct sock *)s;
> -
> +       for (sk =3D bt_accept_get(parent, NULL); sk; sk =3D next) {
>                 /* Prevent early freeing of sk due to unlink and sock_kil=
l */
> -               sock_hold(sk);
>                 lock_sock(sk);
>
>                 /* Check sk has not already been unlinked via
>                  * bt_accept_unlink() due to serialisation caused by sk l=
ocking
>                  */
> -               if (!bt_sk(sk)->parent) {
> +               if (bt_sk(sk)->parent !=3D parent) {
>                         BT_DBG("sk %p, already unlinked", sk);
>                         release_sock(sk);
>                         sock_put(sk);
>
> -                       /* Restart the loop as sk is no longer in the lis=
t
> -                        * and also avoid a potential infinite loop becau=
se
> -                        * list_for_each_entry_safe() is not thread safe.
> -                        */
>                         goto restart;
>                 }
>
> +               next =3D bt_accept_get(parent, sk);
> +
>                 /* sk is safely in the parent list so reduce reference co=
unt */
>                 sock_put(sk);
>
> @@ -310,6 +343,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, s=
truct socket *newsock)
>                                 sock_graft(sk, newsock);
>
>                         release_sock(sk);
> +                       if (next)
> +                               sock_put(next);
>                         return sk;
>                 }
>
> @@ -518,18 +553,28 @@ EXPORT_SYMBOL(bt_sock_stream_recvmsg);
>
>  static inline __poll_t bt_accept_poll(struct sock *parent)
>  {
> -       struct bt_sock *s, *n;
> +       struct bt_sock *bt =3D bt_sk(parent);
> +       struct bt_sock *s;
>         struct sock *sk;
> +       __poll_t mask =3D 0;
> +
> +       spin_lock_bh(&bt->accept_q_lock);
> +       list_for_each_entry(s, &bt->accept_q, accept_q) {
> +               int state;
>
> -       list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q=
) {
>                 sk =3D (struct sock *)s;
> -               if (sk->sk_state =3D=3D BT_CONNECTED ||
> -                   (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &=
&
> -                    sk->sk_state =3D=3D BT_CONNECT2))
> -                       return EPOLLIN | EPOLLRDNORM;
> +               state =3D READ_ONCE(sk->sk_state);
> +
> +               if (state =3D=3D BT_CONNECTED ||
> +                   (test_bit(BT_SK_DEFER_SETUP, &bt->flags) &&
> +                    state =3D=3D BT_CONNECT2)) {
> +                       mask =3D EPOLLIN | EPOLLRDNORM;
> +                       break;
> +               }
>         }
> +       spin_unlock_bh(&bt->accept_q_lock);
>
> -       return 0;
> +       return mask;
>  }
>
>  __poll_t bt_sock_poll(struct file *file, struct socket *sock,
> --
> 2.34.1

https://sashiko.dev/#/patchset/06a6b4549acba207847ce532dedbf1c95ab22d13.177=
4925231.git.wangjiexun2025%40gmail.com

Seem valid to me.

--=20
Luiz Augusto von Dentz

