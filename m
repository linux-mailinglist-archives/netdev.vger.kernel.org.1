Return-Path: <netdev+bounces-46134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9C67E18E0
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 03:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE761C20A8B
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 02:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7CBA31;
	Mon,  6 Nov 2023 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJvCXdWh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C938F5B
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 02:44:48 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AF8170E
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 18:44:43 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa071d100so81473587b3.1
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 18:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238683; x=1699843483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeiiEJbRtsTNAyw99p8ZCn3Vjnqo19hTPl7OEJ2oi/s=;
        b=rJvCXdWh8S1Gd4tToKvM81jKvUKCb2Nv1RvfKjqBAB4zJ9uVpyamZ7D1sYUypZ2XYd
         3vy05d8Blxvd1tBSSTir5DXhbnnnIfr5+415ytQHE5zCwBiiQU15K4rz1cZxtOaKD1CO
         eMNBZiaKXonAJXX4KRuTQ6KUaaoWYlYS/oYU3wH7/QC/NbK00Efl3Q3e370cxFsHmVwL
         IaW02HhYnpNbZWjuiUSKbUlZywv9jZjKvAhG5N2i8qhQ74n6AfVHQTDUd9vSbyaFQ/IN
         CLDvm7OiHv2NGatzSIq8Ue1YZFh9DqXQX9RY1wdraOlVVG1hsEBZeHAWw0aMmCIHVDcw
         znNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238683; x=1699843483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeiiEJbRtsTNAyw99p8ZCn3Vjnqo19hTPl7OEJ2oi/s=;
        b=h4lOJU4470KGJBh1uLtz90WnamnYBuEssSdLJnXWNOGcVqKM+6hNWopiwRlHZad4j3
         At0yeFD2j+LDi4jwAXgDpT3SdstRc0dq6/TiuQ+F27GiAUa7xOozFYSeg0Nrlu6Lalx/
         xra8Lw2yqspMdmK/7tmZhXC0ONSZjfgqI9/rbN5rAP8AqVr/iF4McdaZBDs+cJTEnats
         L0sg/3//xEgkOzY4DOfmAg8jRdOuSIhEVhObtqSGDQDAPZPdVPy/IElEKUsKo2rU+Cj7
         iKbJU8EjNBWcgjf65jQIIRK4g+rHpy76l6ehKfoIRSgaMVsmzsNVTuEIcvODYiVrpS7e
         iL6A==
X-Gm-Message-State: AOJu0Yxd19VIimY284UAyiD+3Ep65tLBGs24T+a/4A2Ge13FsDbwUplW
	VvGlR0EXOU5F1NDpgDswG3wqQYt0JeYMB6w6OstBghU0wmxwgoNXYXnejQr8ZmQZI0vt2Ot/2xs
	jSgpfTeXs12zDNueB0lmJ97t0ET9e3R3a2m/m+e0qtinOH3bu3zDfuV2ovptkKgowOyt8JvdMWu
	8=
X-Google-Smtp-Source: AGHT+IGXB1Wk5WKMXZr8HTN6imbMYrfy8ASdQjy/ozkx0p4xonXE7b4iNBr/Mhu3s45eIhJrmpU89xDxoCb7QfNOog==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:828d:0:b0:d9a:4421:6ec5 with SMTP
 id r13-20020a25828d000000b00d9a44216ec5mr537997ybk.3.1699238682207; Sun, 05
 Nov 2023 18:44:42 -0800 (PST)
Date: Sun,  5 Nov 2023 18:44:10 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-12-almasrymina@google.com>
Subject: [RFC PATCH v3 11/12] net: add SO_DEVMEM_DONTNEED setsockopt to
 release RX pages
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an interface for the user to notify the kernel that it is done
reading the NET_RX dmabuf pages returned as cmsg. The kernel will
drop the reference on the NET_RX pages to make them available for
re-use.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/uapi/asm-generic/socket.h |  1 +
 include/uapi/linux/uio.h          |  4 ++++
 net/core/sock.c                   | 36 +++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index aacb97f16b78..eb93b43394d4 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,7 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SO_DEVMEM_DONTNEED	97
 #define SO_DEVMEM_HEADER	98
 #define SCM_DEVMEM_HEADER	SO_DEVMEM_HEADER
 #define SO_DEVMEM_OFFSET	99
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index ae94763b1963..71314bf41590 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -26,6 +26,10 @@ struct cmsg_devmem {
 	__u32 frag_token;
 };
 
+struct devmemtoken {
+	__u32 token_start;
+	__u32 token_count;
+};
 /*
  *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
  */
diff --git a/net/core/sock.c b/net/core/sock.c
index 1d28e3e87970..4ddc6b11d915 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1051,6 +1051,39 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	return 0;
 }
 
+static noinline_for_stack int
+sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	struct devmemtoken tokens[128];
+	unsigned int num_tokens, i, j;
+	int ret;
+
+	if (sk->sk_type != SOCK_STREAM || sk->sk_protocol != IPPROTO_TCP)
+		return -EBADF;
+
+	if (optlen % sizeof(struct devmemtoken) || optlen > sizeof(tokens))
+		return -EINVAL;
+
+	num_tokens = optlen / sizeof(struct devmemtoken);
+	if (copy_from_sockptr(tokens, optval, optlen))
+		return -EFAULT;
+
+	ret = 0;
+	for (i = 0; i < num_tokens; i++) {
+		for (j = 0; j < tokens[i].token_count; j++) {
+			struct page *page = xa_erase(&sk->sk_user_pages,
+						     tokens[i].token_start + j);
+
+			if (page) {
+				page_pool_page_put_many(page, 1);
+				ret++;
+			}
+		}
+	}
+
+	return ret;
+}
+
 void sockopt_lock_sock(struct sock *sk)
 {
 	/* When current->bpf_ctx is set, the setsockopt is called from
@@ -1538,6 +1571,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 
+	case SO_DEVMEM_DONTNEED:
+		ret = sock_devmem_dontneed(sk, optval, optlen);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 		break;
-- 
2.42.0.869.gea05f2083d-goog


