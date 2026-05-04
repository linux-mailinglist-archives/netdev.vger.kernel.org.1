Return-Path: <netdev+bounces-284019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHXaIcXw+Gmr3QIAu9opvQ
	(envelope-from <netdev+bounces-284019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:17:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6BB4C31EE
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C089F3099A82
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A93F20E7;
	Mon,  4 May 2026 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="fkYQIm3u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A463EF649
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921823; cv=pass; b=CQcTbXxLBRLQDVDw3if1BfD5ncOPCUT8EXVUiAAyomSDfPAJIc6JYRnZGsJZlTLSBeoL758+QjO7WxSn0mgbcyIxL7T3tirfUUl43FIjbSN/t4jVYdTAKkBLQ9WBJISAhMfzDUynA3wa0zQPuNUgcoTRx2pFWDDIA1m/eMHWI9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921823; c=relaxed/simple;
	bh=fbW1lmwMKbR7U8sH3t0pUYRt9uZb1c97zojBGzt05M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shXP74En4ByzRqD4Zfr9eDnVliKln0UoMpDpJIXPJRPosgSlxT4mFuJcXLC8+6UYYJKp+K6QTJxUtCWDpzh9C9cWKMAP77QXYFILiOkhnUAa1PTvJHIyUhJuBjPYf1gH2cOl4m6BVW9ewYy/FLFfys13s6EesFWJbeCVmtl+3Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=fkYQIm3u; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so3220423b3a.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 12:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777921822; cv=none;
        d=google.com; s=arc-20240605;
        b=MInuKN/tORL4B62HJcOTMp/TDlpsmyfFaGKqlXlu06XtpLIQhRUGqrEFOLO8nwkTWz
         DmArqey74MpdPQUPG3lMoAe1yVllh6VTjPMFf+LKkpt/qGuWup1ZIL/5eg1xRFkUa0tG
         sR2ZGhpNQqVHci41TASlab6sCdHO/ofxfmgljwW7rk9h1cPbp9hb4SxbyWj6qunqOgo3
         CVvz9YloVuq6IjKFjYW8DTK/Z654IROT1ERqZKuiO1HtQ6MAjlDPHPQG9sHil1Uz33l+
         kYK7mXYGi08WXWHMQajh7adBdcRGAFL7cFsNPgi64jSs8mVV425dr2ESUg8mW7V5llJm
         NN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5KH9OfxNuUuiTqz2j5K8SaWZtcRXyNCgll5zc0AiOiE=;
        fh=M7Ns+JwX+EmeCLfL5XkejFp8h571IOx6czi1e4tzE/U=;
        b=FVbrFKRyHs4E2Jr6QmhYTXOPr8GdIA53J2FvcmDB7r9YV0S3qH5vLVXLT68yWj2Yji
         ChQN+LZQFhhW6tD97cYo7DjUeYs06Acn1QzgFkubaW+bUzxIO6gWEBELWEWMArpR8h8j
         ql9QGeJUDj2Z5DRn8neqoJBOonqfAfwFFXcy+a5o9bVfcXr7CiyUyigHTxYZagsa5h1F
         cGvxvfXSBsOJTZWdsViIWUHdsj08KoHCXceS1knwZ0c/y6qhaY8YlX4y0+Qx/96l+Rjs
         1bsoYS7AoGIzylA4tjWYYuMPeBFf/g5aJLZv/aCBxVo1vDKwrvvXGwTteY2tQmEKU3TP
         b8fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777921822; x=1778526622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KH9OfxNuUuiTqz2j5K8SaWZtcRXyNCgll5zc0AiOiE=;
        b=fkYQIm3uMeQKSTvhIRTYcWNeE9mgrZ5mpjPsaQ7RPzOaVe2Fu2vJNlbHvSeelEnhqo
         uyUrGRSA2TliD6unB+yiP67n41EYuYq7fY6xQqBTbhLLC1BtlI1ocGsZiOknOqUuPIFA
         JAvx8C8yaTvpgKA6rk/DRAy7sh0WeVoie6jBqvB3/sMkcLwA+EgjaL1aJvRd2xjr1Bm3
         bz3VNSrkvEfh+dFgMRrf0LSnQChh8GrvWEvleMPFBA8ELTuoosyjvB2GRAS0Oq6+yXw7
         QtWtLsGMyIwaQ97OXFwNAXFli/2jq3OupMmUGujxgI1GOzgIEKhtbyDrJxqQIcyrTaqg
         I4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777921822; x=1778526622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KH9OfxNuUuiTqz2j5K8SaWZtcRXyNCgll5zc0AiOiE=;
        b=NTiz+k1A3GFHnwZq7elErcdAyb21GaeQVpxVMYW3xpO4IVuXbNhDsIOvd09Q1ILCMU
         ir4nL+caSMjWyeqAXd8mwSRbSF+vWJ18n/fdrM3gBbNPG74u+lt6D3CcmfMxZx6+9JSM
         HZYBpSfjZ+BDYDc25AujHWyya3t+Ln0X9CjKdcvCmYXJ5KiIrBK2yADiSvJ5isThojBS
         /PbeH4/OIzDtvXVrTjCSVO/R8bGuwQCW6KFLTv4NHNb+Mzc45pN1hqTuOQDVF1IIjUsk
         hxyFVj9W5uD7WJOp7gOErYEqwxP7wPBNFp7AlmkyNLeWqfec0gG1hjIGrdqa2QemTWQo
         qQhw==
X-Forwarded-Encrypted: i=1; AFNElJ/OLCT4W4vUORtjvpVY4/pI21GagCHVojO+P2bM3xfdMbqPX8RSIgjgfkHFiMhJAqsESqmRc2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63ineHktbPMEbzRMmtzmxlJG5Ac9YDMz+ujbkZrAokC6SWANu
	EBQGe/VP0p8NEoUhATk7S8JyA4tGP+xPUzEqgZpNX/hgvCWVVqAD7oGq7jop3vtlzlCM6XFW7hh
	fC/xkJDmwHsbgjLWe+MtT/RTisWEoDSC/TvxrIWKKwM4wmOD7EV0=
X-Gm-Gg: AeBDietTZNsaLnZvSXSybW1qSbEfiozFUmAcjqC37SSZgDfrPqVkPsQqbUqkATVNAL0
	TxeKbX33kgnWxdLdOvxlA7Il4DOloucALFuBp2cnI4CYJHFSnBBeSD/EwWUZsfXOE4Akoop4SDv
	Iyh4vyU1ufHD+wJeXAsWmc3wFQPUlCAlvwDnxjpXw/mZkZltMdsypHPsRLpdtLq+81izW7ZefQl
	TzPDxyFPsBVgNna7m20LYKhTJmfQid6oDbEV4LqUZGX/i70r1EIANsu7XOgsxvKSzAxipwXPIb5
	Jap4gGt+2Y9psl1PRVkpefBLp0ycEg==
X-Received: by 2002:a05:6a00:139f:b0:838:1c02:276c with SMTP id
 d2e1a72fcca58-8381c022c71mr3828983b3a.40.1777921821498; Mon, 04 May 2026
 12:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503115138.2467123-1-edumazet@google.com>
In-Reply-To: <20260503115138.2467123-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 4 May 2026 15:10:10 -0400
X-Gm-Features: AVHnY4IkprHfvbLb0IQZKmFgY1hy-preBjv03pBRmWe8MSplASkGANteRd6Lw5U
Message-ID: <CAM0EoMk8sXEyV6OLWtTRBm9mZsj34sZ_pLHYZi7+3Tcv01U72A@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc: qdisc: provide tcm_handle and
 tcm_parent to kernel dump requests
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DE6BB4C31EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284019-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:email]

On Sun, May 3, 2026 at 7:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> linux-7.2 can filter "tc qdisc show ..." on tcm_handle / tcm_parent and
> reduce dump costs.
>
> Old kernels ignore these values.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  tc/tc_qdisc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
> index b3c395b65c2f6b47abbcb6aa37b7dc1f080032e8..7c3e7cb36b4830bca9f2785a5=
8b38d319ec4b563 100644
> --- a/tc/tc_qdisc.c
> +++ b/tc/tc_qdisc.c
> @@ -408,6 +408,9 @@ static int tc_qdisc_list(int argc, char **argv)
>                 argc--; argv++;
>         }
>
> +       /* Recent kernels (7.2+) can filter on tcm_parent/tcm_handle */
> +       req.t.tcm_parent =3D filter_parent;
> +       req.t.tcm_handle =3D filter_handle;
>
>         if (d[0]) {
>                 req.t.tcm_ifindex =3D ll_name_to_index(d);
> --
> 2.54.0.545.g6539524ca2-goog
>

