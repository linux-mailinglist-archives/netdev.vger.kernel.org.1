Return-Path: <netdev+bounces-289955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO0zF0zBDWr32wUAu9opvQ
	(envelope-from <netdev+bounces-289955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:12:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C003658F5FC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01798300AB01
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581D03E2754;
	Wed, 20 May 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEnWpFHO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5183E5EF3
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285638; cv=pass; b=sA7SuAJFRbLdE0RNONflLdlyqUbogCPITxMCz4EjceNGVjwsBsBSy75aLdz8L76hdrVPj3I9pLW51FT9tuX/FqyHtdlRH54GLQT3/D80O575HMJLJK/HUdC4mIE2oART8hnXqKTkiOV5zT95sNumdiqtRMlbhkRfiQOaF229Mvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285638; c=relaxed/simple;
	bh=a6iXobOed3sRPLM97RG69+W2Ae5HzR387KOzpzYwEYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpCZ8N63wW/1GVoSA/LW/7wrXVQRL59dS3mIYgDUY891qH8QzOI+ndUF0t8XPrXguG1DE+N6Bymifr10DyVkea16B78chu76rh+H/RLhqoGO6lNIhctAn9cefDKRZQ7yGFX479Ua+6pLjQiY3oM5PM3DAP/5jOHjnWEgox3R0Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEnWpFHO; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65890a6ca20so5455715d50.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779285633; cv=none;
        d=google.com; s=arc-20240605;
        b=DxtPNyY/HZDNYGwQoXqPmvXO6ycKwMWcWlw0PmbqeJhoOWC/SERlOS+PiV5UtTBrzS
         585i6v9LRSc1VtEN/YmWyXvll82wGzifGZPxM85xkUhWLTctlzBKlo7x/fAe4cJzHkFm
         rztytkIAB7OG+EzgkW/QcqsKM0m+lt2+N8ZUQQENuBbau+4eNd62yg0yO5eecfdTtPtr
         Kq/zkLb88QZI01iuOTDGcReyUWBTgmNg0hWLgkVHCYwSVYqobmAtxnP4pW47PHNfeSxj
         DkcFpGhYiI0zZpJsmeui9n0I3W1W83oAXohF6oz0QEWhW8VJZCTJwxAOJA783chOd1mr
         +Q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/7oaXQ1qryt8g+zZj0bxtOQOINmT0mwFoGI1KqRN0Ws=;
        fh=+5Xl0mrqg7CT1OaFO2RHz5EyhNfvyHlYTiEaZDwG6a0=;
        b=jYixXIsU4zk+tqCWA0ZOQw4ViFEMg+4RfDy0lmfQOUeJujKNHO7lAsEvbEL6etaABU
         J2D9X7PMR+H+J9bIjGF78V3q8/vpcvncLIPZlxPIRIV7Hebub4TT0oVqG4fInhw2TZ23
         c/sp1fpzDq1SS2aPXaz/g9S8yQqng71wxqaiGB6HGBbvHkxj98/zCxu3tvNrf5rbyb8z
         OmVPG06Tj4aU66+8YggvTb32gHUCrOLUdqx8Xx0AziPAa3Qtvd0EJ+7Hdq/6K5lPr7aE
         Aju8NVqriNWSFByYdi+CItRG0q22pvsS6NnM4nZMFKGvJpKZrwy7HFJ28LXLpT4oOrqS
         p8/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285633; x=1779890433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7oaXQ1qryt8g+zZj0bxtOQOINmT0mwFoGI1KqRN0Ws=;
        b=fEnWpFHO7e2e/VG5DchH7LlYMbMdAfAmL3bznExqaIWg6YvPBBaQtm8fTLKHkukjiQ
         v7DZMO1fGA7ywqfhOKgWbL1/p/3t78DMj2sFb7cwigEZtmcJmVb3C0zcM1xV/3RHAgOY
         Mv1ooeFagkOhWQfeMaFiLJ3GjpZgCf3XEdc95ihRfUMJL6tBW/7EtPvDYGWQBh2rH33Z
         rFHzjbpldgkgchoYwUEOP5cCmkYSpLjQ3+0ZJscxLcu+3Y9CWcOh+1yeCyzYf3YjH0kQ
         ed7bBOiwf70tpeX7qjuDr2CeMGjUph1GcmuriSf/JaqILD5I4TUGi0A0aBmHVFNxCMMs
         XVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285633; x=1779890433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/7oaXQ1qryt8g+zZj0bxtOQOINmT0mwFoGI1KqRN0Ws=;
        b=iXoznSK3yyAhs2bj3Djs2nozjXBTrm0LnEKdm/QS0vFj1p+GHIgijCOnV8cu/Ed6kH
         QQPmRGyynR+ng1rjT5FaQv2zYpWmTQ+D29s+1p23GJrdzLq2zSWrCzGz0VxA1hShj8M6
         gIAWeWESh6nhK1QnvKw7VqcfSApZNdbjInniEY5xLeW+L/wlZKck30jP4NeUMqhEZ6/i
         X4RaZT5/y1yuSuz+jJNNDRB2zduugxKL3YIV+8pCseT2U1rNFbNqi2+4VQNk1baPh2uK
         Uu+wWKPGWhgk/xg/+TlQXryehEdpfVEIoFahieTBhoONNBaOm3XQmAx74ZHBkBJttzLK
         wDLg==
X-Forwarded-Encrypted: i=1; AFNElJ9EgPUhCXWflPRYvppL7FUPbh0K7z7qYYCiEm/asloi7C/wNt0zlzm0lqunm63X0M1Q1Q5mUnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNenBU8Bsi9DENA8WkVET48vfNZcIbCSowfY7cxc8erkI8qlLB
	7zjovq/OHfnlSoaNTUcK8X0f5uZ7/u96Zs/kOC6yGDVRtjnNza9lIuM62ZdLRXcOZyGpcxit7gb
	DuQ6hpS4T2QKZGUAmT3/oqcd0lMHfe6s=
X-Gm-Gg: Acq92OEJPXf7Hn0xpobwTy3N0w1jV4IWAcNPwTAdoHb3hrziByMkNsRchiJ1D58LG79
	LLcFl41UOKzbjSjZg+2qXyCOnn/3ebtZ0jWxagbO9wMA0si7L0eYQ+Oqq8H6YpxnMRpDZ8qJzpA
	bbtQa9+7KPmIcQ91uysXalfp9bgfchNCX8RARjKqIUsKHV8qitioXj8XVrHOc3owHntXE36YWmV
	NNZoy7A0uQqv9EBjywvmOrullAqYoAhS3SBpzyyzqQ/wZJpJL9tvjST++Nx5qRA1dyhUXSXNaZh
	lVC8v2nU9ulD0pdtI6qxzVzNBRolAR/oQu0tWGwrpGhGvN0tAVdK3B4bjJMNcyE8y7zMUA==
X-Received: by 2002:a05:690e:2502:10b0:656:30a1:70e3 with SMTP id
 956f58d0204a3-65e228469fcmr20278863d50.53.1779285633031; Wed, 20 May 2026
 07:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
In-Reply-To: <20260520135034.1060859-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 10:00:21 -0400
X-Gm-Features: AVHnY4IdFrVeMyCQglDoLVCdIs5UC3o9rHcSrMblsA2cwCBRrhR-fiJEvzNPD_M
Message-ID: <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289955-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C003658F5FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Wed, May 20, 2026 at 9:50=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
> signaling packets up to the channel MTU and dispatches each command
> without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
> within radio range can send a fixed-channel CID 0x0001 packet that is
> larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
> pairing.
>
> In a real-radio stock-kernel run, one 681-byte signaling
> packet containing 168 zero-length ECHO_REQ commands made the target
> transmit 168 ECHO_RSP frames over about 220 ms.
>
> Define Linux's BR/EDR signaling MTU as the spec minimum of 48 bytes and
> reject larger signaling packets before dispatching their commands. When
> the over-MTUsig packet contains a request command, send one
> L2CAP_COMMAND_REJECT_RSP with L2CAP_REJ_MTU_EXCEEDED and the first
> request identifier; packets for which no valid request command is found
> are dropped.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarit=
o@gmail.com
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> I reproduced the stock behavior with a real-radio BR/EDR ACL link and a
> harness that sends a single fixed-channel signaling packet containing
> packed zero-length ECHO_REQ commands. The patched code builds for
> net/bluetooth/l2cap_core.o on x86_64 defconfig. There are no in-tree
> Bluetooth selftests that reference l2cap_sig_channel(), L2CAP_SIG_MTU,
> or L2CAP_ECHO_REQ.
>
> The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
> trace to the initial git import; no later introducing commit is
> available for a Fixes tag.
>
> Changes in v2:
> - Replace the per-PDU echo-count cap with the MTUsig direction from
>   review.
> - Reject the whole over-MTUsig signaling packet with one
>   L2CAP_REJ_MTU_EXCEEDED command reject.
> - Add L2CAP_SIG_MTU and drop over-MTUsig packets when no valid request
>   command identifier is found.
>
> v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@=
gmail.com
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 60 +++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 5172afee54943..e0a1f2293679a 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -33,6 +33,7 @@
>  /* L2CAP defaults */
>  #define L2CAP_DEFAULT_MTU              672
>  #define L2CAP_DEFAULT_MIN_MTU          48
> +#define L2CAP_SIG_MTU                  48      /* BR/EDR signaling MTU *=
/
>  #define L2CAP_DEFAULT_FLUSH_TO         0xFFFF
>  #define L2CAP_EFS_DEFAULT_FLUSH_TO     0xFFFFFFFF
>  #define L2CAP_DEFAULT_TX_WINDOW                63
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 77dec104a9c36..5417e3cb0636d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5626,6 +5626,55 @@ static inline void l2cap_sig_send_rej(struct l2cap=
_conn *conn, u16 ident)
>         l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej)=
;
>  }
>
> +static bool l2cap_sig_cmd_is_req(u8 code)
> +{
> +       switch (code) {
> +       case L2CAP_CONN_REQ:
> +       case L2CAP_CONF_REQ:
> +       case L2CAP_DISCONN_REQ:
> +       case L2CAP_ECHO_REQ:
> +       case L2CAP_INFO_REQ:
> +       case L2CAP_CONN_PARAM_UPDATE_REQ:
> +       case L2CAP_LE_CONN_REQ:
> +       case L2CAP_ECRED_CONN_REQ:
> +       case L2CAP_ECRED_RECONF_REQ:
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static u8 l2cap_sig_first_req_ident(const struct sk_buff *skb)
> +{
> +       const u8 *data =3D skb->data;
> +       unsigned int len =3D skb->len;
> +
> +       while (len >=3D L2CAP_CMD_HDR_SIZE) {
> +               const struct l2cap_cmd_hdr *cmd =3D (const void *)data;
> +               u16 cmd_len =3D le16_to_cpu(cmd->len);
> +
> +               if (cmd->ident && l2cap_sig_cmd_is_req(cmd->code))
> +                       return cmd->ident;
> +
> +               if (cmd_len > len - L2CAP_CMD_HDR_SIZE)
> +                       break;
> +
> +               data +=3D L2CAP_CMD_HDR_SIZE + cmd_len;
> +               len -=3D L2CAP_CMD_HDR_SIZE + cmd_len;
> +       }

Weird, does the AI come up with this? The id is actually _not_
important because the error code will essentially indicate that the
entire packet was rejected. Therefore, it doesn't matter if the id is
for a request or a response, it still needs rejection if it exceeds
the MTU, so this seems overengineered.

> +       return 0;
> +}
> +
> +static inline void l2cap_sig_send_mtu_rej(struct l2cap_conn *conn, u8 id=
ent)
> +{
> +       struct l2cap_cmd_rej_mtu rej;
> +
> +       rej.reason =3D cpu_to_le16(L2CAP_REJ_MTU_EXCEEDED);
> +       rej.max_mtu =3D cpu_to_le16(L2CAP_SIG_MTU);
> +       l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej)=
;
> +}
> +
>  static inline void l2cap_sig_channel(struct l2cap_conn *conn,
>                                      struct sk_buff *skb)
>  {
> @@ -5638,6 +5687,17 @@ static inline void l2cap_sig_channel(struct l2cap_=
conn *conn,
>         if (hcon->type !=3D ACL_LINK)
>                 goto drop;
>
> +       if (skb->len > L2CAP_SIG_MTU) {
> +               u8 ident =3D l2cap_sig_first_req_ident(skb);
> +
> +               BT_DBG("signaling packet exceeds MTU");
> +
> +               if (ident)
> +                       l2cap_sig_send_mtu_rej(conn, ident);
> +
> +               goto drop;
> +       }
> +
>         while (skb->len >=3D L2CAP_CMD_HDR_SIZE) {
>                 u16 len;
>
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz

