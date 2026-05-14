Return-Path: <netdev+bounces-287760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PyvHlcZBWrOSQIAu9opvQ
	(envelope-from <netdev+bounces-287760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:37:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3953C60E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9801B3031C90
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124E42D9EFB;
	Thu, 14 May 2026 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="zniNwZfD"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3689214812
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719060; cv=none; b=NWtS9t1ncmHDruxdFS8gpXSgMGeuE/wrADNvflkOzWJ5CLa1qwSahYOd1hwLkycGxafj3nafHJDcZIaXZkASoa8KStRlrjWdMNC2IdhIyYKlp/dN8U/nWmqIHCjvRqWjH+nHi+RUvUoUZC7GlDcQ8Tm3f1tCLXXD5d2GQm6+1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719060; c=relaxed/simple;
	bh=caXvENs8q+1/HfW8pow/EXtpvb5WkYq+eldkbaXlaPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdpgXIOBwDU0FD5j9loR+GvXiazqcCfh/dlOeAaZ6Qov/2hiGe/EATe+65AC/ECJ4530EeTi+Oy4QKqVibf6ahL/d/i1b4H845UXYaqUgmfbntONMxLd9FTw1KNVMf3/NBUh5OGRW5Dii9+2ZxiRAfDM+SFFuMslIHn+qR1En60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=zniNwZfD; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5B93E2C0613;
	Thu, 14 May 2026 12:37:35 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1778719055;
	bh=Zyw5S7e80tZjT6K7eiv0YgjyNq4sB8EyFKPPSt3XNeM=;
	h=From:To:Cc:Subject:Date:From;
	b=zniNwZfDHR/nrVZt9jQhmY7DIDirrmseqwSMZck0bCbP7cBrSMWaxhXa0wxGZxWcH
	 QnAPjEnbRu5iXXkj0iBxwxGLqIws8zqJDQ/T8JahPa7jkgwDU7En64FeUId8SaWdzq
	 SXWSsAem3p8kMMfxeQlpbp9HZzCvJSPLAJGAVZ0uK1Y8fUcFqFfhGsJ64Xvqtkr8Nr
	 8N6u9xhz7AadEuU1lE4kdvNN+YHrkmbvZfKsWtfWckj7eoZ3XTH2ePUiQJviCiQ5to
	 T3q6HyyaW2dJCirKvaPr3EprSsDzEb8Rkfg1vAed8HgaHs6IxYOvbgFXP/c/e2lHce
	 rlVnAaYiArh2A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a05194f0000>; Thu, 14 May 2026 12:37:35 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.12])
	by pat.atlnz.lc (Postfix) with ESMTP id 1AC4F13ED2A;
	Thu, 14 May 2026 12:37:35 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 18C5790022D; Thu, 14 May 2026 12:37:35 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Blair Steven <blair.steven@alliedtelesis.co.nz>,
	Carl Smith <carl.smith@alliedtelesis.co.nz>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH net-next] i40e: Avoid repeating RX filter warning
Date: Thu, 14 May 2026 12:37:33 +1200
Message-ID: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Es1xrjcA c=1 sm=1 tr=0 ts=6a05194f a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=NGcC8JguVDcA:10 a=ngL9nt1HdWMmO1MQNKYA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Rspamd-Queue-Id: 87E3953C60E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[alliedtelesis.co.nz,quarantine];
	R_DKIM_ALLOW(-0.20)[alliedtelesis.co.nz:s=mail181024];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287760-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris.packham@alliedtelesis.co.nz,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[alliedtelesis.co.nz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alliedtelesis.co.nz:email,alliedtelesis.co.nz:mid,alliedtelesis.co.nz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When the i40e runs out of space for RX filters the driver switches to
promiscuous mode and warns that it has done so. In scenarios with a
large number of these filters this can generate a lot of warnings. For
example:

  $ dmesg -c > /dev/null
  $ ip link add dev br0 type bridge vlan_filtering 1 vlan_default_pvid 1
  $ ip link set dev eth7 master br0
  $ bridge vlan add vid 1 dev eth7 pvid untagged self
  $ bridge vlan add vid 2-4094 dev eth7 tagged
  $ dmesg
  [   25.601705] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing ove=
rflow promiscuous on PF
  [   25.601833] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing ove=
rflow promiscuous on PF
  [   25.601961] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing ove=
rflow promiscuous on PF
  [   25.602088] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing ove=
rflow promiscuous on PF
  [   25.602216] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing ove=
rflow promiscuous on PF
  [   25.602344] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing ove=
rflow promiscuous on PF
  ...

Use test_and_set_bit() so that the warning is only issued when the
driver enables promiscuous mode and not on the addition of subsequent RX
filters.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Resend with net-next tag

 drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
index 926d001b2150..8741990b5a5e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2408,10 +2408,11 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, c=
onst char *vsi_name,
=20
 	if (fcnt !=3D num_add) {
 		if (vsi->type =3D=3D I40E_VSI_MAIN) {
-			set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
-			dev_warn(&vsi->back->pdev->dev,
-				 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
-				 libie_aq_str(aq_status), vsi_name);
+			if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state)) {
+				dev_warn(&vsi->back->pdev->dev,
+					 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
+					 libie_aq_str(aq_status), vsi_name);
+			}
 		} else if (vsi->type =3D=3D I40E_VSI_SRIOV ||
 			   vsi->type =3D=3D I40E_VSI_VMDQ1 ||
 			   vsi->type =3D=3D I40E_VSI_VMDQ2) {
@@ -2461,10 +2462,11 @@ i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, c=
onst char *vsi_name,
 	}
=20
 	if (aq_ret) {
-		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
-		dev_warn(&vsi->back->pdev->dev,
-			 "Error %s, forcing overflow promiscuous on %s\n",
-			 libie_aq_str(hw->aq.asq_last_status), vsi_name);
+		if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state)) {
+			dev_warn(&vsi->back->pdev->dev,
+				 "Error %s, forcing overflow promiscuous on %s\n",
+				 libie_aq_str(hw->aq.asq_last_status), vsi_name);
+		}
 	}
=20
 	return aq_ret;
--=20
2.54.0


